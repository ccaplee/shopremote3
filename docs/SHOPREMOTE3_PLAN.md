# ShopRemote3 프로젝트 계획서

**작성일**: 2026-04-02
**프로젝트명**: ShopRemote3 (ShopRemote2 분할 프로젝트)
**버전**: 3.0.1
**GitHub**: ccaplee/shopremote3 (공개 저장소)
**기본 서버**: ai.ilv.co.kr
**RS_PUB_KEY**: dfqFDvOl5RvM8gfY4Nb2eUoYubr9m444DBBMB+1fTEIjYAAunduNzy/pHWax/oA+DGxIp84fWL7jSY56CEP2kQ==

---

## A. 제품 개요

### 목표
ShopRemote2의 단일 애플리케이션을 **Host 앱**과 **Remote 앱** 두 개의 별도 애플리케이션으로 분할하여, 각 역할에 맞는 단순화된 UI와 기능을 제공한다.

### ShopRemote3 Host (호스트 앱)
- **역할**: 매장에 설치되어 원격 제어를 받는 용도
- **대상 사용자**: 매장 점원, POS 담당자
- **테마 색상**: 빨간색 (#E74C3C 기본색, #C0392B 악센트색)
- **주요 기능**:
  - 디바이스 ID와 비밀번호 표시
  - 원격 접속 수신 대기
  - 서비스 자동 시작
  - 접속 로그 관리
  - 권한 설정 (화면공유, 파일전송, 클립보드, 키보드/마우스 입력)

### ShopRemote3 Remote (원격 앱)
- **역할**: 관리자/컨트롤러가 사용하여 Host를 원격 제어
- **대상 사용자**: 관리자, 매장 운영 관리자
- **테마 색상**: 파란색 (#2980B9 기본색, #3498DB 악센트색)
- **주요 기능**:
  - 원격 ID 입력 및 자동 연결
  - 원격 데스크톱 뷰어
  - 파일 전송 기능
  - 주소록/즐겨찾기 관리
  - 다중 세션 탭 지원

---

## B. 기술 전략

### 분할 접근 방식: Single Codebase, Multiple Entry Points

**핵심 원칙**: 하나의 소스코드베이스에서 Rust 기능 플래그(feature flags)와 Flutter 진입점(entry points)을 이용하여 두 개의 서로 다른 앱을 빌드한다.

#### Rust 계층 (src/lib.rs 및 관련 모듈)
```
Feature Flags:
- host-only: Host 앱 전용 빌드
  - client 모듈 제외
  - port_forward 모듈 제외
  - whiteboard 모듈 제외
  - ui_session_interface 제외

- remote-only: Remote 앱 전용 빌드
  - server 모듈 제외
  - ui_cm_interface 제외
  - 바이너리 크기 최적화 및 불필요한 코드 제거

기본값 (dual mode): 두 기능 모두 활성화
```

조건부 컴파일 예시:
```rust
// src/lib.rs
#[cfg(not(feature = "host-only"))]
mod client;  // Host 앱에서는 제외

#[cfg(not(any(target_os = "ios")))]
#[cfg(not(feature = "host-only"))]
mod port_forward;  // Host 앱에서는 제외

#[cfg(not(feature = "host-only"))]
mod ui_session_interface;  // Host 앱에서는 제외

#[cfg(not(feature = "remote-only"))]
mod server;  // Remote 앱에서는 제외

#[cfg(not(feature = "remote-only"))]
mod ui_cm_interface;  // Remote 앱에서는 제외

/// Host-only 빌드 여부 확인 함수
pub fn is_host_only_build() -> bool {
    cfg!(feature = "host-only")
}

/// Remote-only 빌드 여부 확인 함수
pub fn is_remote_only_build() -> bool {
    cfg!(feature = "remote-only")
}
```

#### Flutter 계층 (flutter/lib/)
```
Entry Points:
1. lib/main_host.dart: Host 앱 진입점
   - isHostOnly = true 설정
   - Host UI 로드

2. lib/main_remote.dart: Remote 앱 진입점
   - isRemoteOnly = true 설정
   - Remote UI 로드

3. lib/main.dart: 기본 듀얼모드 진입점 (호환성)
```

공통 플래그 (common.dart):
```dart
/// Host 전용 모드 여부
bool isHostOnly = false;

/// Remote 전용 모드 여부
bool isRemoteOnly = false;
```

#### 빌드 명령어

**Host 앱 (Linux/macOS 예)**:
```bash
# Rust 빌드
cargo build --features "flutter,host-only" --lib --release

# Flutter 빌드
cd flutter
flutter build linux --release --dart-entrypoint lib/main_host.dart
```

**Remote 앱 (Linux/macOS 예)**:
```bash
# Rust 빌드 (remote-only feature flag 사용)
cargo build --features "flutter,remote-only" --lib --release

# Flutter 빌드
cd flutter
flutter build linux --release --dart-entrypoint lib/main_remote.dart
```

**Windows 예**:
```bash
# Host
build.py --flutter --host-only

# Remote
build.py --flutter
```

---

## C. Host 앱 기능 명세

### 화면 구성

#### 1. 홈 페이지 (DesktopHomePageHost)
**위치**: `flutter/lib/desktop/pages/desktop_home_page_host.dart`

**주요 구성 요소**:
- **디바이스 ID 표시**: 고정된 12자리 숫자 ID 표시
- **임시 비밀번호 표시**: 보안 상의 이유로 선택적 표시
- **접속 상태**: 현재 연결된 Remote 클라이언트 수 표시
- **권한 패널**:
  - 화면 공유 허용/거부
  - 파일 전송 허용/거부
  - 클립보드 공유 허용/거부
  - 키보드/마우스 입력 허용/거부
- **접속 로그**: 최근 접속 기록 (최대 50개 표시)
- **서비스 상태**: 로컬 서비스 활성화 상태

#### 2. 설정 페이지 (DesktopSettingPage - Host 모드)
**위치**: `flutter/lib/desktop/pages/desktop_setting_page.dart` (조건부)

**Host 전용 설정**:
- **기본 설정**
  - 언어 선택
  - 테마 설정
  - 자동 시작 활성화/비활성화
  - 최소화 시 시스템 트레이로 숨김
- **보안 설정**
  - 비밀번호 자동 재생성
  - 비밀번호 갱신 주기 설정
  - 접속 시 확인 메시지
- **서버 설정**
  - 기본 서버: ai.ilv.co.kr
  - 커스텀 서버 설정 (선택사항)
  - 암호화 설정
- **로그 설정**
  - 접속 로그 보존 기간
  - 로그 삭제 옵션

### UI 특성

#### Host 테마 색상
```dart
class HostTheme {
  // 주요 색상
  static const Color primary = Color(0xFFE74C3C);        // 빨간색
  static const Color accent = Color(0xFFC0392B);         // 진한 빨간색
  static const Color warning = Color(0xFFF39C12);        // 경고 주황색

  // 배경
  static const Color darkBg = Color(0xFF1A1A2E);         // 어두운 배경
  static const Color cardBg = Color(0xFF242E48);         // 카드 배경

  // 텍스트
  static const Color textPrimary = Color(0xFFFFFFFF);    // 주 텍스트
  static const Color textSecondary = Color(0xFFBDBDBD);  // 보조 텍스트

  // 경계선
  static const Color border = Color(0xFF3A4558);         // 경계선
}
```

#### Host 앱 제거 UI 요소
다음 요소들은 Host 앱에서 **완전히 제거**되어야 함:
- 원격 ID 입력 필드 및 연결 버튼
- 주소록 (Address Book)
- 즐겨찾기 관리
- 원격 데스크톱 뷰어
- 파일 전송 클라이언트
- 카메라 보기
- 포트 포워딩
- 터미널
- 연결 탭 (Tab 인터페이스에서 제거)

---

## D. Remote 앱 기능 명세

### 화면 구성

#### 1. 홈 페이지 (DesktopHomePage - Remote 모드)
**위치**: `flutter/lib/desktop/pages/desktop_home_page.dart` (기존 유지, 조건부)

**주요 구성 요소**:
- **원격 ID 입력**: 텍스트 필드로 Host의 ID 입력
- **연결 버튼**: "연결" 버튼으로 Host 연결 시도
- **주소록 패널**:
  - 즐겨찾기 Host 목록
  - 최근 연결 목록
  - 빠른 검색
- **연결 상태**: 현재 활성 연결 수 표시

#### 2. 원격 데스크톱 뷰어
**위치**: `flutter/lib/desktop/screen/desktop_remote_screen.dart`

**주요 기능**:
- Host의 화면 실시간 스트리밍
- 마우스 이동 및 클릭 제어
- 키보드 입력 전송
- 줌 인/아웃
- 스크린샷 캡처
- 전체화면 모드
- 상단 도구모음 (마우스 모드, 드래그 모드 전환)

#### 3. 파일 전송
**위치**: `flutter/lib/desktop/screen/desktop_file_transfer_screen.dart`

**주요 기능**:
- Host의 파일 시스템 탐색
- 로컬 파일 선택 및 업로드
- Host의 파일 다운로드
- 다중 파일 선택
- 진행률 표시

#### 4. 주소록 및 즐겨찾기
**위치**: `flutter/lib/models/address_book.dart`, `flutter/lib/desktop/pages/connection_page.dart`

**주요 기능**:
- Host 정보 저장 (ID, 별명, 태그)
- 그룹화 및 분류
- 최근 사용 목록
- 즐겨찾기 표시
- 빠른 연결

#### 5. 설정 페이지 (DesktopSettingPage - Remote 모드)
**위치**: `flutter/lib/desktop/pages/desktop_setting_page.dart` (조건부)

**Remote 전용 설정**:
- **기본 설정**
  - 언어 선택
  - 테마 설정
- **연결 설정**
  - 기본 서버: ai.ilv.co.kr
  - 커스텀 서버 설정
  - 자동 재연결
- **입력 설정**
  - 마우스 감도
  - 키보드 레이아웃
  - 클립보드 동기화
- **UI 설정**
  - 도구모음 위치
  - 알림 설정

### UI 특성

#### Remote 테마 색상
```dart
class RemoteTheme {
  // 주요 색상
  static const Color primary = Color(0xFF2980B9);        // 파란색
  static const Color accent = Color(0xFF3498DB);         // 밝은 파란색
  static const Color success = Color(0xFF27AE60);        // 성공 초록색

  // 배경
  static const Color darkBg = Color(0xFF1A1A2E);         // 어두운 배경
  static const Color cardBg = Color(0xFF242E48);         // 카드 배경

  // 텍스트
  static const Color textPrimary = Color(0xFFFFFFFF);    // 주 텍스트
  static const Color textSecondary = Color(0xFFBDBDBD);  // 보조 텍스트

  // 경계선
  static const Color border = Color(0xFF3A4558);         // 경계선
}
```

#### Remote 앱 제거 UI 요소
다음 요소들은 Remote 앱에서 **완전히 제거**되어야 함:
- 자신의 디바이스 ID 표시 (홈페이지)
- 자신의 비밀번호 표시
- 서버 모드/수신 모드 토글
- 접속 수신 대기 기능
- 접속 로그 (Server 관련)
- 권한 설정 패널
- 서비스 시작/중지 버튼
- 커넥션 매니저 (CM) 관련 UI

---

## E. 테마/디자인 사양

### 색상 팔레트

#### Host 앱 (빨간색 테마)
| 항목 | 색상 코드 | 설명 |
|------|---------|------|
| Primary | #E74C3C | 주요 버튼, 헤더 배경 |
| Accent | #C0392B | 강조, 호버 상태 |
| Warning | #F39C12 | 경고, 주의 표시 |
| Dark BG | #1A1A2E | 창 배경색 |
| Card BG | #242E48 | 카드/패널 배경 |
| Border | #3A4558 | 분할선, 경계선 |
| Text Primary | #FFFFFF | 주 텍스트 |
| Text Secondary | #BDBDBD | 보조 텍스트 |

#### Remote 앱 (파란색 테마)
| 항목 | 색상 코드 | 설명 |
|------|---------|------|
| Primary | #2980B9 | 주요 버튼, 헤더 배경 |
| Accent | #3498DB | 강조, 호버 상태 |
| Success | #27AE60 | 성공, 활성 표시 |
| Dark BG | #1A1A2E | 창 배경색 |
| Card BG | #242E48 | 카드/패널 배경 |
| Border | #3A4558 | 분할선, 경계선 |
| Text Primary | #FFFFFF | 주 텍스트 |
| Text Secondary | #BDBDBD | 보조 텍스트 |

### 타이포그래피
- **헤더**: Roboto 24px Bold
- **제목**: Roboto 18px Bold
- **본문**: Roboto 14px Regular
- **보조**: Roboto 12px Regular

### 아이콘
- 기본 MaterialIcons 사용
- Host 전용 아이콘: 락(잠금), 방패(보안)
- Remote 전용 아이콘: 네트워크, 마우스, 키보드

### 레이아웃
- **최소 창 크기**: 800 x 600px
- **권장 창 크기**: 1200 x 800px
- **전체화면 지원**: Remote 데스크톱 뷰어에서 필수

---

## F. 버전/패키지 변경사항

### 버전 정보
| 항목 | ShopRemote2 | ShopRemote3 |
|------|-----------|-----------|
| 애플리케이션 버전 | 2.0.1 | 3.0.1 |
| 패키지명 (Android) | com.shopremote2.app | com.shopremote3.host / com.shopremote3.remote |
| 번들ID (iOS) | com.shopremote2.app | com.shopremote3.host / com.shopremote3.remote |
| 창 이름 | ShopRemote2 | ShopRemote3 Host / ShopRemote3 Remote |
| 바이너리명 | shopremote2 (.exe/.dmg 등) | shopremote3-host / shopremote3-remote |

### Cargo.toml 변경

```toml
[package]
name = "shopremote3"  # 3.0.0 → 3.0.1
version = "3.0.1"    # 2.0.1 → 3.0.1

[features]
host-only = []       # 새로 추가
remote-only = []     # Remote 앱 빌드: server, ui_cm_interface 제외

[lib]
name = "libshopremote3"

[package.metadata.bundle]
# 기본값 (build.py가 빌드 시점에 동적으로 변경)
name = "ShopRemote3"
identifier = "com.shopremote3.app"

# build.py 동적 설정 방식:
# --host-only 빌드 시: build.py가 Cargo.toml의 metadata.bundle.name/identifier를
#   "ShopRemote3 Host" / "com.shopremote3.host"로 임시 변경 후 빌드, 빌드 완료 후 복원
# --remote-only 빌드 시: build.py가 마찬가지로
#   "ShopRemote3 Remote" / "com.shopremote3.remote"로 임시 변경 후 빌드, 빌드 완료 후 복원
# Android: android/app/build.gradle의 applicationId도 동일하게 동적 변경
# iOS: ios/Runner.xcodeproj의 PRODUCT_BUNDLE_IDENTIFIER도 동적 변경

[[bin]]
name = "shopremote3-host" / "shopremote3-remote"
```

### build.py 변경

```python
parser.add_argument(
    '--host-only',
    action='store_true',
    help='Build host-only variant'
)

parser.add_argument(
    '--remote-only',
    action='store_true',
    help='Build remote-only variant'
)

# 이진 이름 결정
binary_name = 'shopremote3-host' if args.host_only else 'shopremote3-remote' if args.remote_only else 'shopremote3'

# Flutter 진입점
dart_entrypoint = 'lib/main_host.dart' if args.host_only else 'lib/main_remote.dart' if args.remote_only else ''
```

### 서버 주소 및 보안 키

기본 서버 (libs/hbb_common/src/config.rs):
```rust
pub const RENDEZVOUS_SERVER: &str = "ai.ilv.co.kr";
pub const RS_PUB_KEY: &str = "dfqFDvOl5RvM8gfY4Nb2eUoYubr9m444DBBMB+1fTEIjYAAunduNzy/pHWax/oA+DGxIp84fWL7jSY56CEP2kQ==";
```

---

## G. 파일 변경 목록

### Core 파일

#### 1. Cargo.toml
**파일 경로**: `/Cargo.toml`
```
변경사항:
- package.name: shopremote2 → shopremote3
- version: 2.0.1 → 3.0.1
- lib.name: libshopremote2 → libshopremote3
- features 추가: host-only = []
- metadata.bundle.name: ShopRemote2 → ShopRemote3
- metadata.bundle.identifier: com.shopremote2.app → com.shopremote3.host / com.shopremote3.remote (조건부)
```

#### 2. src/lib.rs
**파일 경로**: `/src/lib.rs`
```
변경사항:
- #[cfg(not(feature = "host-only"))] 추가 (client 모듈)
- #[cfg(not(feature = "host-only"))] 추가 (port_forward 모듈)
- #[cfg(not(feature = "host-only"))] 추가 (whiteboard 모듈)
- #[cfg(not(feature = "host-only"))] 추가 (ui_session_interface 모듈)
- pub fn is_host_only_build() 함수 추가
```

#### 3. src/flutter_ffi.rs
**파일 경로**: `/src/flutter_ffi.rs`
```
변경사항:
- Host 전용 빌드에서 일부 FFI 바인딩 제외
- remote 관련 FFI 함수 조건부 컴파일
```

#### 4. build.py
**파일 경로**: `/build.py`
```
변경사항:
- --host-only 플래그 추가 (이미 exists: 줄 134-136)
- --remote-only 플래그 추가 (옵션)
- hbb_name 변경: shopremote3-host / shopremote3-remote
- exe_path 동적 설정
- get_version() 함수: 3.0.1 반환
- build_flutter_* 함수에서 host_only 파라미터 처리 (이미 exists)
- output_name 동적 설정 (이미 부분 구현)
```

### Flutter 파일

#### 5. flutter/lib/common.dart
**파일 경로**: `/flutter/lib/common.dart`
```
변경사항:
- isHostOnly 플래그 추가 (이미 exists: 줄 82)
- isRemoteOnly 플래그 추가
- MyTheme 클래스: 동적 색상 적용
  - Host 모드일 때 빨간색 테마
  - Remote 모드일 때 파란색 테마
  - 기본값은 Blue 테마
```

#### 6. flutter/lib/main_host.dart (신규 생성)
**파일 경로**: `/flutter/lib/main_host.dart`
```
생성 내용:
- Host 전용 진입점
- isHostOnly = true 설정
- initEnv(kAppTypeMain) 호출
- DesktopTabPage 로드 (Host 모드)
```

#### 7. flutter/lib/main_remote.dart (신규 생성)
**파일 경로**: `/flutter/lib/main_remote.dart`
```
생성 내용:
- Remote 전용 진입점
- isRemoteOnly = true 설정
- initEnv(kAppTypeMain) 호출
- DesktopTabPage 로드 (Remote 모드)
```

#### 8. flutter/lib/main.dart
**파일 경로**: `/flutter/lib/main.dart`
```
변경사항:
- 기본 진입점 유지 (호환성)
- isHostOnly/isRemoteOnly 플래그 기본값 false
- 기존 dual-mode 로직 유지
```

#### 9. flutter/lib/desktop/pages/desktop_home_page_host.dart (신규 생성)
**파일 경로**: `/flutter/lib/desktop/pages/desktop_home_page_host.dart`
```
생성 내용:
- Host 전용 홈 페이지
- 원격 ID 입력 필드 제거
- 연결 버튼 제거
- 주소록 제거
- 디바이스 ID 표시
- 비밀번호 표시
- 접속 상태 표시
- 권한 패널
- 접속 로그
- 서비스 상태
```

#### 10. flutter/lib/desktop/pages/desktop_tab_page.dart
**파일 경로**: `/flutter/lib/desktop/pages/desktop_tab_page.dart`
```
변경사항:
- isHostOnly 검사 추가 (이미 부분 구현: 줄 49-51)
- Host 모드일 때 DesktopHomePageHost 로드
- Remote 모드일 때 DesktopHomePage 로드
- Host 모드에서 탭 조정 (원격 접속 탭 제거)
```

#### 11. flutter/lib/desktop/pages/desktop_setting_page.dart
**파일 경로**: `/flutter/lib/desktop/pages/desktop_setting_page.dart`
```
변경사항:
- Host/Remote 설정 분기
- Host 모드: 자동 시작, 비밀번호 갱신, 서비스 설정 표시
- Remote 모드: 연결 설정, 입력 설정 표시
- 공통 설정: 언어, 테마, 기본 서버
```

#### 12. flutter/lib/desktop/pages/desktop_home_page.dart
**파일 경로**: `/flutter/lib/desktop/pages/desktop_home_page.dart`
```
변경사항:
- Remote 전용 UI 유지
- isHostOnly 검사: Host 모드일 때 이 페이지 로드 안 함
- Remote 기능만 포함:
  - 원격 ID 입력
  - 연결 버튼
  - 주소록
  - 최근 연결 목록
```

### 구성 파일

#### 13. libs/hbb_common/src/config.rs
**파일 경로**: `/libs/hbb_common/src/config.rs`
```
변경사항:
- RENDEZVOUS_SERVER: ai.ilv.co.kr 설정 확인
- RS_PUB_KEY: 공개 키 설정 확인
- Version: 3.0.1 업데이트
- Package ID: 조건부 설정
```

### CI/CD 파일

#### 14. .github/workflows/build.yml (또는 해당 CI/CD 파일)
**파일 경로**: `/.github/workflows/build.yml`
```
변경사항:
- Host 빌드 작업:
  - cargo build --features flutter,host-only
  - flutter build --dart-entrypoint lib/main_host.dart
  - 출력: shopremote3-host-{version}.exe / .deb / .dmg

- Remote 빌드 작업:
  - cargo build --features flutter
  - flutter build --dart-entrypoint lib/main_remote.dart
  - 출력: shopremote3-remote-{version}.exe / .deb / .dmg

- Release 생성: 두 바이너리 모두 포함
```

---

## H. 구현 순서 (4단계)

### Phase 1: 기반 설정 및 패키지 변경
**기간**: 1-2주
**담당**: 빌드 시스템 담당자

**작업 항목**:
1. Cargo.toml 버전 업데이트 (2.0.1 → 3.0.1)
2. Cargo.toml 패키지명 업데이트 (shopremote2 → shopremote3)
3. libs/hbb_common/src/config.rs에서 서버/키 설정 확인
4. build.py --host-only 플래그 동작 확인
5. Flutter pubspec.yaml 패키지명 업데이트 (필요시)
6. 애플리케이션 이름 상수 업데이트 (consts.dart)

**검증**:
- `cargo build --features flutter,host-only` 성공 확인
- `cargo build --features flutter` 성공 확인

---

### Phase 2: Rust 기능 플래그 구현
**기간**: 1-2주
**담당**: Rust 백엔드 담당자

**작업 항목**:
1. src/lib.rs에 host-only 기능 플래그 조건부 컴파일 추가
   - `#[cfg(not(feature = "host-only"))]` for client 모듈
   - `#[cfg(not(feature = "host-only"))]` for port_forward 모듈
   - `#[cfg(not(feature = "host-only"))]` for whiteboard 모듈
   - `#[cfg(not(feature = "host-only"))]` for ui_session_interface 모듈

2. src/flutter_ffi.rs에서 Host 전용 바인딩 제외
   - remote 관련 FFI 함수 조건부 처리

3. is_host_only_build() 함수 구현 (이미 구현됨)
4. 모든 컴파일 오류 해결

**검증**:
```bash
cargo build --features flutter,host-only --release
cargo build --features flutter --release
```

---

### Phase 3: Flutter UI 분할 및 진입점 구현
**기간**: 2-3주
**담당**: Flutter UI 담당자

**작업 항목**:
1. flutter/lib/common.dart 업데이트
   - isHostOnly, isRemoteOnly 플래그 정의
   - MyTheme 클래스: 동적 색상 시스템
   - Host/Remote 테마 색상 정의

2. flutter/lib/main_host.dart 생성
   - Host 전용 진입점
   - isHostOnly = true 설정

3. flutter/lib/main_remote.dart 생성
   - Remote 전용 진입점
   - isRemoteOnly = true 설정

4. flutter/lib/desktop/pages/desktop_home_page_host.dart 생성
   - Host 홈페이지
   - 원격 ID 입력 필드 제거
   - 연결 버튼 제거
   - 주소록 제거
   - 디바이스 ID, 비밀번호, 권한, 로그 등 표시

5. flutter/lib/desktop/pages/desktop_tab_page.dart 수정
   - isHostOnly 검사
   - Host/Remote 홈페이지 조건부 로드

6. flutter/lib/desktop/pages/desktop_home_page.dart 수정
   - Remote 전용 UI 확인
   - Host 기능 제거 확인

7. flutter/lib/desktop/pages/desktop_setting_page.dart 수정
   - Host/Remote 설정 분기
   - 조건부 설정 항목 표시

**검증**:
```bash
flutter run --dart-entrypoint lib/main_host.dart
flutter run --dart-entrypoint lib/main_remote.dart
```

---

### Phase 4: 빌드 시스템 및 CI/CD
**기간**: 1-2주
**담당**: DevOps/빌드 담당자

**작업 항목**:
1. build.py 정확성 검증
   - --host-only 플래그 동작
   - 바이너리 명명 규칙 확인
   - Flutter 진입점 지정 확인

2. .github/workflows/build.yml 업데이트
   - Host 빌드 작업 추가
   - Remote 빌드 작업 추가
   - Release 생성 수정

3. 배포 패키지 생성
   - Windows: .exe (portable + installer)
   - macOS: .dmg
   - Linux: .deb / .tar.gz

4. 버전 관리
   - Git 태그: v3.0.1
   - Release notes 작성

**검증**:
- Host 빌드 아티팩트 확인
- Remote 빌드 아티팩트 확인
- 버전 정보 확인

---

## I. 리스크 및 완화 전략

### 기술적 리스크

| 리스크 | 영향도 | 완화 전략 |
|--------|--------|---------|
| Rust FFI 바인딩 오류 | 높음 | Phase 2에서 충분한 테스트, Dart 코드와 병렬 검증 |
| Flutter 진입점 문제 | 중간 | 별도 테스트 빌드, 에뮬레이터에서 먼저 테스트 |
| 테마 색상 불일치 | 낮음 | 디자인 시스템 문서화, QA 체크리스트 |
| 조건부 컴파일 누락 | 중간 | 코드 리뷰, 전체 기능 테스트 |

### 일정 리스크

| 리스크 | 영향도 | 완화 전략 |
|--------|--------|---------|
| Phase 간 의존성 | 높음 | 파트 간 주간 동기화, 마일스톤 점검 |
| 플랫폼별 빌드 문제 | 중간 | Windows, macOS, Linux 병렬 테스트 |
| 예상 밖의 버그 | 중간 | 버퍼 시간 (1주), 핫픽스 계획 |

### 품질 보증

| 항목 | 체크사항 |
|------|---------|
| 기능 테스트 | Host 모드에서 원격 제어 수신 정상 동작 |
| | Remote 모드에서 원격 제어 전송 정상 동작 |
| | 네트워크 연결 및 재연결 동작 |
| 성능 테스트 | 메모리 사용량 증가 없음 |
| | 화면 렌더링 프레임율 유지 |
| UI/UX 테스트 | Host 테마 색상 일관성 |
| | Remote 테마 색상 일관성 |
| | UI 응답성 및 사용성 |
| 호환성 테스트 | Windows 10/11 |
| | macOS 10.14+ |
| | Linux (Ubuntu 20.04+) |

---

## J. 리소스 및 타임라인

### 권장 팀 구성
- **Rust 백엔드 담당자**: 1명 (Phase 2)
- **Flutter UI 담당자**: 1-2명 (Phase 3)
- **빌드/DevOps 담당자**: 1명 (Phase 4)
- **QA/테스터**: 1명 (모든 Phase)
- **프로젝트 매니저**: 1명 (전체 조율)

### 예상 타임라인
```
Week 1-2: Phase 1 (기반 설정)
Week 3-4: Phase 2 (Rust 기능 플래그)
Week 5-7: Phase 3 (Flutter UI 분할)
Week 8-9: Phase 4 (빌드 시스템 및 CI/CD)
Week 10: 최종 테스트 및 배포 준비
```

**총 예상 기간**: 10주 (평행 작업 가능하면 단축 가능)

---

## K. 배포 전 체크리스트

### 코드 준비
- [ ] Cargo.toml 버전 3.0.1로 업데이트
- [ ] 모든 조건부 컴파일 (#[cfg]) 구현 완료
- [ ] Flutter 진입점 파일 생성 완료
- [ ] Host/Remote 홈페이지 구현 완료
- [ ] 테마 색상 적용 완료

### 빌드 검증
- [ ] cargo build --features flutter,host-only 성공
- [ ] cargo build --features flutter 성공
- [ ] build.py --flutter --host-only 성공
- [ ] build.py --flutter 성공
- [ ] 모든 플랫폼 (Windows, macOS, Linux) 빌드 성공

### 기능 테스트
- [ ] Host 앱: 디바이스 ID 표시
- [ ] Host 앱: 비밀번호 표시
- [ ] Host 앱: 권한 설정 동작
- [ ] Host 앱: 접속 로그 기록
- [ ] Remote 앱: 원격 ID 입력 동작
- [ ] Remote 앱: 원격 제어 연결
- [ ] Remote 앱: 화면 공유 정상 작동
- [ ] Remote 앱: 파일 전송 동작

### 문서 준비
- [ ] SHOPREMOTE3_PLAN.md 검토 및 승인
- [ ] 사용자 가이드 업데이트
- [ ] 관리자 가이드 업데이트
- [ ] API 문서 업데이트 (필요시)

### 배포 준비
- [ ] GitHub 저장소 설정 (ccaplee/shopremote3)
- [ ] GitHub Actions CI/CD 설정
- [ ] Release v3.0.1 생성 준비
- [ ] 배포 아티팩트 서명
- [ ] 안티바이러스 스캔

---

## L. 향후 계획

### 단기 (3-6개월)
- ShopRemote3 정식 배포
- 사용자 피드백 수집
- 버그 수정 릴리즈 (3.0.2, 3.0.3 등)
- 성능 최적화

### 중기 (6-12개월)
- 추가 기능 개발
  - 화면 녹화 기능
  - 다중 모니터 지원 개선
  - 클라우드 저장소 연동
- 보안 강화
  - 2FA 지원 강화
  - 엔드-투-엔드 암호화 개선

### 장기 (12개월 이상)
- 모바일 버전 개발 (iOS/Android)
- 웹 클라이언트 개선
- 엔터프라이즈 기능 추가
  - 팀 관리
  - 감사 로그
  - API 개발

---

## 첨부: 색상 코드 참조

### Host 테마 (빨간색)
```css
/* RGB 값 */
Primary:        rgb(231, 76, 60)    #E74C3C
Accent:         rgb(192, 57, 43)    #C0392B
Warning:        rgb(243, 156, 18)   #F39C12
Dark BG:        rgb(26, 26, 46)     #1A1A2E
Card BG:        rgb(36, 46, 72)     #242E48
Border:         rgb(58, 69, 88)     #3A4558
Text Primary:   rgb(255, 255, 255)  #FFFFFF
Text Secondary: rgb(189, 189, 189)  #BDBDBDB
```

### Remote 테마 (파란색)
```css
/* RGB 값 */
Primary:        rgb(41, 128, 185)   #2980B9
Accent:         rgb(52, 152, 219)   #3498DB
Success:        rgb(39, 174, 96)    #27AE60
Dark BG:        rgb(26, 26, 46)     #1A1A2E
Card BG:        rgb(36, 46, 72)     #242E48
Border:         rgb(58, 69, 88)     #3A4558
Text Primary:   rgb(255, 255, 255)  #FFFFFF
Text Secondary: rgb(189, 189, 189)  #BDBDBDB
```

---

**문서 버전**: 1.0
**마지막 수정**: 2026-04-02
**검토자**: (기획 담당자 서명 예정)
