# QA 보고서: ShopRemote2/shopremote2 명칭 마이그레이션

## 요약
코드베이스 전체에서 **2,285개의 ShopRemote2/shopremote2 참조** 발견
- 변경 필요: **41개 (UI 문자열 및 표시명)**
- 유지해야 함: **1,237개 (패키지 식별자, 임포트, 시스템 식별자)**
- 코드 식별자: **14개 (클래스명, 상수명)**
- 댓글/문서: **81개 (참고용, 선택적)**

---

## 1. 변경 필요 (NEEDS CHANGE) - UI 문자열 및 표시명

### 1.1 Android 매니페스트 및 리소스
| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `flutter/android/app/src/main/AndroidManifest.xml` | 28 | `android:label="ShopRemote2"` | UI 레이블 |
| `flutter/android/app/src/main/AndroidManifest.xml` | 49 | `android:label="ShopRemote2 Input"` | UI 레이블 (입력 서비스) |
| `flutter/android/app/src/main/res/values/strings.xml` | 2 | `<string name="app_name">ShopRemote2</string>` | 앱 이름 리소스 |
| `flutter/android/app/src/main/res/values/strings.xml` | 3 | `accessibility_service_description` with "ShopRemote2" | 접근성 문자열 |

### 1.2 Android 코드 상수
| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `flutter/android/app/src/main/kotlin/com/shopremote2/app/MainService.kt` | 49 | `const val DEFAULT_NOTIFY_TITLE = "ShopRemote2"` | 알림 제목 |
| `flutter/android/app/src/main/kotlin/com/shopremote2/app/MainService.kt` | 601 | `val channelId = "ShopRemote2"` | 알림 채널 ID |
| `flutter/android/app/src/main/kotlin/com/shopremote2/app/MainService.kt` | 604 | `val channelName = "ShopRemote2 Service"` | 알림 채널명 |
| `flutter/android/app/src/main/kotlin/com/shopremote2/app/BootReceiver.kt` | 38 | `Toast.makeText(context, "ShopRemote2 is Open"` | 토스트 메시지 |
| `flutter/android/app/src/main/kotlin/com/shopremote2/app/FloatingWindowService.kt` | 95 | `translate("Show ShopRemote2")` | 메뉴 항목 |

### 1.3 iOS 설정
| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `flutter/ios/Runner/Info.plist` | 10, 18 | `<string>ShopRemote2</string>` | Info.plist 설정값 |

### 1.4 macOS 권한 스크립트
| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `src/platform/privileges_scripts/agent.plist` | 6 | `com.carriez.ShopRemote2_server` | macOS 에이전트 ID |
| `src/platform/privileges_scripts/agent.plist` | 29 | `/Applications/ShopRemote2.app/Contents/MacOS/ShopRemote2` | 앱 경로 |
| `src/platform/privileges_scripts/daemon.plist` | 6 | `com.carriez.ShopRemote2_service` | macOS 데몬 ID |
| `src/platform/privileges_scripts/daemon.plist` | 7 | `/Applications/ShopRemote2.app/Contents/MacOS/service` | 서비스 경로 |

### 1.5 빌드 스크립트 (build.py)
| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `build.py` | 433 | `./build/macos/Build/Products/Release/ShopRemote2.app` | macOS 앱 번들 경로 |
| `build.py` | 436 | `create-dmg --volname "ShopRemote2 Installer"` | DMG 볼륨 이름 |
| `build.py` | 527 | `mv target/release/shopremote2.exe target/release/ShopRemote2.exe` | Windows 실행파일명 |
| `build.py` | 537 | `cp -rf target/release/ShopRemote2.exe` | Windows 배포 파일명 |
| `build.py` | 590-605 | 여러 `ShopRemote2.app` 참조 | macOS 코드사인 경로 |
| `build.py` | 608 | `create-dmg "ShopRemote2 %s.dmg"` | DMG 파일명 |

### 1.6 Flutter Dart 코드
| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `flutter/lib/web/bridge.dart` | 1612-1613 | 주석 및 비교: `!= "ShopRemote2"` | 기본 클라이언트 체크 |
| `flutter/lib/desktop/pages/desktop_setting_page.dart` | 2590 | 주석: "ShopRemote2" 권한 설정 | 설정 가이드 |
| `flutter/lib/desktop/widgets/tabbar_widget.dart` | 643 | `"ShopRemote2"` 문자열 | 알려진 피어 |
| `flutter/lib/mobile/pages/settings_page.dart` | - | `translate('Keep ShopRemote2 background service')` | UI 문자열 |
| `flutter/lib/mobile/pages/settings_page.dart` | - | `translate('About ShopRemote2')` | UI 문자열 |

### 1.7 Rust 코드
| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `src/lang.rs` | 여러곳 | `if s.contains("ShopRemote2")` 로직 | 앱명 대체 로직 |
| `src/common.rs` | 여러곳 | `!= "ShopRemote2"` 비교, 타입정의 | 기본 앱 식별 |
| `src/platform/windows.rs` | 여러곳 | `"ShopRemote2"` 경로 및 레지스트리 | Windows 경로 |
| `src/platform/macos.rs` | 여러곳 | `"ShopRemote2"` 앱 경로 | macOS 경로 |

### 1.8 기타 빌드 관련
| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `res/msi/preprocess.py` | 여러곳 | `"ShopRemote2"` 기본값 및 치환 | MSI 설치관리자 |
| `res/job.py` | 208 | `"ShopRemote2PrinterDriver"` in root | 경로 확인 |

---

## 2. 유지해야 함 (KEEP AS-IS) - 패키지 및 시스템 식별자

### 2.1 Android 애플리케이션 ID 및 패키지명
**합계: 28개 참조**

Android 패키지 이름(`com.shopremote2.app`)은 애플리케이션의 고유 식별자입니다. 이를 변경하면:
- Play Store에서의 앱 인식 변경
- 사용자 설정 및 캐시 손실
- 기존 설치된 앱과 호환성 문제

**파일:**
- `flutter/android/app/build.gradle` (Line 100): `applicationId "com.shopremote2.app"`
- `flutter/android/app/src/main/AndroidManifest.xml` (Line 3): `package="com.shopremote2.app"`
- `flutter/android/app/src/debug/AndroidManifest.xml` (Line 2): `package="com.shopremote2.app"`
- `flutter/android/app/src/profile/AndroidManifest.xml` (Line 2): `package="com.shopremote2.app"`
- 모든 Kotlin 파일: `package com.shopremote2.app`

### 2.2 Flutter 패키지명
**합계: 473개 참조**

`pubspec.yaml`에서 `name: shopremote2`로 정의된 패키지의 모든 임포트문입니다.

**주요 파일:**
- `flutter/pubspec.yaml` (Line 1): `name: shopremote2`
- 모든 Dart 파일의 `import 'package:shopremote2/...'`

**이유:** Flutter 패키지 시스템의 핵심 식별자이며, 변경하려면:
1. pubspec.yaml 수정
2. 모든 임포트문 일괄 변경 필요
3. 패키지 재배포 필요

### 2.3 네이티브 라이브러리
| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `flutter/android/app/src/main/kotlin/com/shopremote2/app/ffi.kt` | 12 | `System.loadLibrary("shopremote2")` | Rust 네이티브 라이브러리명 |

### 2.4 Firebase 및 Google 서비스
**합계: 6개 참조**

| 파일 | 라인 | 내용 | 사유 |
|------|------|------|------|
| `flutter/ios/Runner/GoogleService-Info.plist` | 16 | CLIENT_ID: `com.shopremote2.app` | Firebase 클라이언트 ID |
| `flutter/ios/Runner/GoogleService-Info.plist` | 18 | DATABASE_URL: `shopremote2` | Firebase 프로젝트명 |
| `flutter/ios/Runner/GoogleService-Info.plist` | 20 | `shopremote2.appspot.com` | Firebase 호스팅 |
| `flutter/ios/Runner/GoogleService-Info.plist` | 34 | `https://shopremote2.firebaseio.com` | Firebase Realtime DB |
| `flutter/ios/exportOptions.plist` | 11-12 | `com.shopremote2.app` / `shopremote2-ios-prod-app-store` | iOS 앱스토어 프로비전 |

**이유:** Firebase 프로젝트 설정과 연계되어 있어 변경 불가

---

## 3. 코드 식별자 (변경 필요)

### 3.1 클래스명 및 상수명
| 파일 | 라인 | 내용 | 변경 제안 | 사유 |
|------|------|------|---------|------|
| `flutter/lib/consts.dart` | 24 | `const String kPlatformAdditionsShopRemote2VirtualDisplays` | `kPlatformAdditionsShopRemote3VirtualDisplays` | 상수명 |
| `flutter/lib/utils/multi_window_manager.dart` | 55-58 | `class ShopRemote2MultiWindowManager` | `class ShopRemote3MultiWindowManager` | 클래스명 |
| `flutter/lib/models/model.dart` | 1635+ | `kPlatformAdditionsShopRemote2VirtualDisplays` 사용처 | 일괄 수정 필요 | 상수 참조 |
| `flutter/lib/models/model.dart` | 4010 | `List<int> get ShopRemote2VirtualDisplays` | `get ShopRemote3VirtualDisplays` | 프로퍼티명 |
| `flutter/lib/models/model.dart` | 4012 | `bool get isShopRemote2Idd` | `get isShopRemote3Idd` | 프로퍼티명 |

### 3.2 영향 범위
이들 식별자는 다음 파일에서 참조됩니다:
- `flutter/lib/common/widgets/toolbar.dart` (2개 참조)
- `flutter/lib/desktop/widgets/tabbar_widget.dart` (1개 참조)
- 기타 모델 관련 파일

---

## 4. 댓글 및 문서 (선택적 - 정보성)

### 4.1 GitHub 링크 참조
**합계: ~50개**

코드 주석의 GitHub 링크들:
```
https://github.com/ccaplee/shopremote2/blob/...
https://github.com/ccaplee/shopremote2-server/...
```

**권장:** 마이그레이션 이력으로 유지, 또는 해당 저장소명이 변경된 경우에만 업데이트

### 4.2 기타 주석
| 파일 | 내용 | 사유 |
|------|------|------|
| `flutter/lib/common.dart` | `// shopremote2://<connect-id>` | URI 스키마 설명 |
| `src/privacy_mode.rs` | `// 가상 디스플레이 지원 (ShopRemote2 서비스 설치 필요)` | 기술 주석 |

---

## 5. 권장 조치

### 5.1 우선순위 높음 (꼭 변경해야 함)
1. **UI 문자열 (41개)** - 사용자 인터페이스이므로 변경 필수
2. **클래스명 및 상수명 (14개)** - 코드 일관성 유지
3. **build.py 스크립트** - 빌드 산출물명 변경

### 5.2 우선순위 중간 (변경하면 좋음)
- 주석 및 문서의 ShopRemote2 참조 업데이트
- macOS 권한 스크립트의 경로명

### 5.3 반드시 유지 (변경 금지)
- Android 패키지명 (`com.shopremote2.app`)
- Flutter 패키지명 (`shopremote2`)
- 네이티브 라이브러리명 (`shopremote2`)
- Firebase 프로젝트 설정

---

## 6. 변경 영향도

| 카테고리 | 파일 수 | 참조 수 | 복잡도 |
|---------|--------|--------|--------|
| UI 문자열 | ~15 | 41 | 낮음 |
| 패키지/식별자 (유지) | ~50 | 1,237 | - (변경 금지) |
| 클래스명/상수 | ~5 | 14 | 중간 |
| 빌드 스크립트 | 2 | ~20 | 중간 |
| 주석/문서 | ~10 | ~81 | 낮음 |

---

## 7. 최종 결론

**총 2,285개 참조 중:**
- **변경 필수: 75개** (UI 문자열 41 + 클래스명 14 + 빌드스크립트 20)
- **변경 금지 (패키지/식별자): 1,237개**
- **선택적 (댓글/문서): 81개**

이는 상대적으로 **관리 가능한 규모**입니다. 자동화 도구를 사용하여 일괄 수정 가능합니다.
