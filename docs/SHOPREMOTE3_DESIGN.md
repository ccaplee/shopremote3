# ShopRemote3 Design Specification Document

**작성일**: 2026-04-02
**버전**: 1.0
**목적**: ShopRemote3의 Host 앱과 Remote 앱에 대한 완전한 디자인 명세

---

## 1. 색상 시스템 (Color System)

### 1.1 Host 앱 (Red Theme) 색상 팔레트

#### Light Mode (밝은 테마)
```dart
class HostLightColors {
  // Primary Colors
  static const Color primary = Color(0xFFE74C3C);        // 주요색 - 밝은 빨간색
  static const Color accent = Color(0xFFC0392B);         // 악센트색 - 진한 빨간색
  static const Color accentLight = Color(0xFFF5A9A3);    // 밝은 빨간색 (호버 상태)

  // Background
  static const Color background = Color(0xFFFAFAFA);     // 앱 배경 (흰색)
  static const Color surface = Color(0xFFFFFFFF);        // 카드/표면 배경 (순백)
  static const Color surfaceHover = Color(0xFFF5EEEB);   // 호버 상태 배경

  // Text Colors
  static const Color textPrimary = Color(0xFF2C3E50);    // 주요 텍스트 (짙은 회색-검정)
  static const Color textSecondary = Color(0xFF95A5A6);  // 보조 텍스트 (회색)
  static const Color textTertiary = Color(0xFFBDC3C7);   // 한 단계 더 약한 텍스트 (연회색)
  static const Color textOnAccent = Color(0xFFFFFFFF);   // 악센트 배경 위의 텍스트

  // Borders & Dividers
  static const Color border = Color(0xFFDDDDDD);         // 표준 경계선
  static const Color borderLight = Color(0xFFF0F0F0);    // 약한 경계선
  static const Color borderAccent = Color(0xFFE74C3C);   // 강조 경계선

  // States
  static const Color hover = Color(0xFFFDEEEB);          // 호버 상태
  static const Color pressed = Color(0xFFE8C2BC);        // 눌린 상태
  static const Color disabled = Color(0xFFE8E8E8);       // 비활성화 상태
  static const Color disabledText = Color(0xFFBBBBBB);   // 비활성화 텍스트

  // Status Colors
  static const Color success = Color(0xFF27AE60);        // 성공/온라인 (초록색)
  static const Color warning = Color(0xFFF39C12);        // 경고 (주황색)
  static const Color error = Color(0xFFE74C3C);          // 에러 (빨간색)
  static const Color info = Color(0xFF3498DB);           // 정보 (파란색)

  // Additional
  static const Color divider = Color(0xFFEEEEEE);        // 구분선
  static const Color shadow = Color(0x1A000000);         // 그림자 (반투명 검정)
  static const Color scrim = Color(0x73000000);          // 모달 배경 스크림
}
```

#### Dark Mode (어두운 테마)
```dart
class HostDarkColors {
  // Primary Colors
  static const Color primary = Color(0xFFE74C3C);        // 주요색 - 빨간색
  static const Color accent = Color(0xFFF85A47);         // 악센트색 - 밝은 빨간색
  static const Color accentLight = Color(0xFFEC7063);    // 중간 밝은 빨간색

  // Background
  static const Color background = Color(0xFF121212);     // 앱 배경 (매우 어두운 회색)
  static const Color surface = Color(0xFF1E1E1E);        // 카드/표면 배경
  static const Color surfaceHover = Color(0xFF2A2A2A);   // 호버 상태 배경

  // Text Colors
  static const Color textPrimary = Color(0xFFFAFAFA);    // 주요 텍스트 (흰색에 가까움)
  static const Color textSecondary = Color(0xFFBDBDBD);  // 보조 텍스트 (연회색)
  static const Color textTertiary = Color(0xFF757575);   // 한 단계 더 약한 텍스트
  static const Color textOnAccent = Color(0xFF000000);   // 악센트 배경 위의 텍스트

  // Borders & Dividers
  static const Color border = Color(0xFF333333);         // 표준 경계선
  static const Color borderLight = Color(0xFF252525);    // 약한 경계선
  static const Color borderAccent = Color(0xFFE74C3C);   // 강조 경계선

  // States
  static const Color hover = Color(0xFF2D2D2D);          // 호버 상태
  static const Color pressed = Color(0xFF3A3A3A);        // 눌린 상태
  static const Color disabled = Color(0xFF2A2A2A);       // 비활성화 상태
  static const Color disabledText = Color(0xFF616161);   // 비활성화 텍스트

  // Status Colors
  static const Color success = Color(0xFF66BB6A);        // 성공/온라인 (밝은 초록)
  static const Color warning = Color(0xFFFFB74D);        // 경고 (밝은 주황)
  static const Color error = Color(0xFFEF5350);          // 에러 (밝은 빨강)
  static const Color info = Color(0xFF42A5F5);           // 정보 (밝은 파랑)

  // Additional
  static const Color divider = Color(0xFF333333);        // 구분선
  static const Color shadow = Color(0x33000000);         // 그림자
  static const Color scrim = Color(0xBB000000);          // 모달 배경 스크림
}
```

### 1.2 Remote 앱 (Blue Theme) 색상 팔레트

#### Light Mode (밝은 테마)
```dart
class RemoteLightColors {
  // Primary Colors
  static const Color primary = Color(0xFF2980B9);        // 주요색 - 진한 파란색
  static const Color accent = Color(0xFF3498DB);         // 악센트색 - 밝은 파란색
  static const Color accentLight = Color(0xFF85C1E9);    // 더 밝은 파란색 (호버)

  // Background
  static const Color background = Color(0xFFFAFAFA);     // 앱 배경 (흰색)
  static const Color surface = Color(0xFFFFFFFF);        // 카드/표면 배경 (순백)
  static const Color surfaceHover = Color(0xFFE8F4F8);   // 호버 상태 배경 (매우 밝은 파랑)

  // Text Colors
  static const Color textPrimary = Color(0xFF1F3A5F);    // 주요 텍스트 (매우 진한 파랑-검정)
  static const Color textSecondary = Color(0xFF34495E);  // 보조 텍스트 (진한 회색)
  static const Color textTertiary = Color(0xFF7F8C8D);   // 한 단계 더 약한 텍스트 (중간 회색)
  static const Color textOnAccent = Color(0xFFFFFFFF);   // 악센트 배경 위의 텍스트

  // Borders & Dividers
  static const Color border = Color(0xFFBDC3C7);         // 표준 경계선
  static const Color borderLight = Color(0xFFECF0F1);    // 약한 경계선
  static const Color borderAccent = Color(0xFF3498DB);   // 강조 경계선

  // States
  static const Color hover = Color(0xFFD6EAF8);          // 호버 상태
  static const Color pressed = Color(0xFFA9CCE3);        // 눌린 상태
  static const Color disabled = Color(0xFFE8E8E8);       // 비활성화 상태
  static const Color disabledText = Color(0xFFBBBBBB);   // 비활성화 텍스트

  // Status Colors
  static const Color success = Color(0xFF27AE60);        // 성공/연결됨 (초록색)
  static const Color warning = Color(0xFFF39C12);        // 경고 (주황색)
  static const Color error = Color(0xFFE74C3C);          // 에러 (빨간색)
  static const Color info = Color(0xFF2980B9);           // 정보 (파란색)

  // Additional
  static const Color divider = Color(0xFFECF0F1);        // 구분선
  static const Color shadow = Color(0x1A000000);         // 그림자
  static const Color scrim = Color(0x73000000);          // 모달 배경 스크림
}
```

#### Dark Mode (어두운 테마)
```dart
class RemoteDarkColors {
  // Primary Colors
  static const Color primary = Color(0xFF3498DB);        // 주요색 - 밝은 파란색
  static const Color accent = Color(0xFF5DADE2);         // 악센트색 - 더 밝은 파란색
  static const Color accentLight = Color(0xFF85C1E9);    // 밝은 파란색

  // Background
  static const Color background = Color(0xFF0F1419);     // 앱 배경 (매우 어두운 파랑)
  static const Color surface = Color(0xFF1A202C);        // 카드/표면 배경
  static const Color surfaceHover = Color(0xFF2D3748);   // 호버 상태 배경

  // Text Colors
  static const Color textPrimary = Color(0xFFEBF4FB);    // 주요 텍스트 (매우 밝은 파랑-흰색)
  static const Color textSecondary = Color(0xFFC7D8E8);  // 보조 텍스트 (밝은 회색)
  static const Color textTertiary = Color(0xFF8892A6);   // 한 단계 더 약한 텍스트
  static const Color textOnAccent = Color(0xFF000000);   // 악센트 배경 위의 텍스트

  // Borders & Dividers
  static const Color border = Color(0xFF2D3748);         // 표준 경계선
  static const Color borderLight = Color(0xFF1E3A4C);    // 약한 경계선
  static const Color borderAccent = Color(0xFF3498DB);   // 강조 경계선

  // States
  static const Color hover = Color(0xFF1E3A4C);          // 호버 상태
  static const Color pressed = Color(0xFF2C5282);        // 눌린 상태
  static const Color disabled = Color(0xFF2A2A2A);       // 비활성화 상태
  static const Color disabledText = Color(0xFF616161);   // 비활성화 텍스트

  // Status Colors
  static const Color success = Color(0xFF48BB78);        // 성공/연결됨 (밝은 초록)
  static const Color warning = Color(0xFFFFB74D);        // 경고 (밝은 주황)
  static const Color error = Color(0xFFF56565);          // 에러 (밝은 빨강)
  static const Color info = Color(0xFF63B3ED);           // 정보 (밝은 파랑)

  // Additional
  static const Color divider = Color(0xFF2D3748);        // 구분선
  static const Color shadow = Color(0x33000000);         // 그림자
  static const Color scrim = Color(0xBB000000);          // 모달 배경 스크림
}
```

### 1.3 ColorScheme 매핑

Host 앱의 ColorScheme (Light):
```dart
ColorScheme.light(
  primary: Color(0xFFE74C3C),              // 주요 상호작용 색
  onPrimary: Color(0xFFFFFFFF),            // 주요색 위의 텍스트
  secondary: Color(0xFFC0392B),            // 보조 상호작용 색
  onSecondary: Color(0xFFFFFFFF),          // 보조색 위의 텍스트
  surface: Color(0xFFFFFFFF),              // 표면/카드 배경
  onSurface: Color(0xFF2C3E50),            // 표면 위의 텍스트
  background: Color(0xFFFAFAFA),           // 앱 배경
  onBackground: Color(0xFF2C3E50),         // 배경 위의 텍스트
  error: Color(0xFFE74C3C),                // 에러 색
  onError: Color(0xFFFFFFFF),              // 에러색 위의 텍스트
)
```

Remote 앱의 ColorScheme (Light):
```dart
ColorScheme.light(
  primary: Color(0xFF2980B9),              // 주요 상호작용 색
  onPrimary: Color(0xFFFFFFFF),            // 주요색 위의 텍스트
  secondary: Color(0xFF3498DB),            // 보조 상호작용 색
  onSecondary: Color(0xFFFFFFFF),          // 보조색 위의 텍스트
  surface: Color(0xFFFFFFFF),              // 표면/카드 배경
  onSurface: Color(0xFF1F3A5F),            // 표면 위의 텍스트
  background: Color(0xFFFAFAFA),           // 앱 배경
  onBackground: Color(0xFF1F3A5F),         // 배경 위의 텍스트
  error: Color(0xFFE74C3C),                // 에러 색
  onError: Color(0xFFFFFFFF),              // 에러색 위의 텍스트
)
```

---

## 2. MyTheme 클래스 수정 설계

### 2.1 현재 MyTheme 클래스 구조

현재 `flutter/lib/common.dart`의 MyTheme 클래스는 글로벌 색상 상수를 정의하고 있으며, 두 개의 정적 ThemeData 객체(`lightTheme`, `darkTheme`)를 제공합니다. 이를 Host/Remote 앱에 따라 동적으로 선택하도록 수정해야 합니다.

### 2.2 수정된 MyTheme 클래스 구조

```dart
class MyTheme {
  MyTheme._();

  // ============= 동적 색상 선택 메서드 =============

  /// 앱 모드에 따라 Primary 색상을 반환합니다
  static Color getPrimaryColor() {
    if (isHostOnly) {
      return Color(0xFFE74C3C);  // Host: 빨간색
    } else if (isRemoteOnly) {
      return Color(0xFF2980B9);  // Remote: 파란색
    } else {
      // Dual mode (기본값)
      return Color(0xFF00B894);  // 기존 기본색 유지
    }
  }

  /// 앱 모드에 따라 Accent 색상을 반환합니다
  static Color getAccentColor() {
    if (isHostOnly) {
      return Color(0xFFC0392B);  // Host: 진한 빨간색
    } else if (isRemoteOnly) {
      return Color(0xFF3498DB);  // Remote: 밝은 파란색
    } else {
      // Dual mode
      return Color(0xFF00B894);  // 기존 기본색 유지
    }
  }

  /// 앱 모드에 따라 배경 색상을 반환합니다 (Light Mode)
  static Color getLightBackgroundColor() {
    return Color(0xFFFAFAFA);  // Host/Remote 공통
  }

  /// 앱 모드에 따라 배경 색상을 반환합니다 (Dark Mode)
  static Color getDarkBackgroundColor() {
    if (isHostOnly || isRemoteOnly) {
      return Color(0xFF121212);
    } else {
      return Color(0xFF18191E);  // 기존
    }
  }

  /// 앱 모드에 따라 Text Primary 색상을 반환합니다 (Light Mode)
  static Color getLightTextPrimary() {
    if (isHostOnly) {
      return Color(0xFF2C3E50);  // Host: 짙은 회색-검정
    } else if (isRemoteOnly) {
      return Color(0xFF1F3A5F);  // Remote: 매우 진한 파랑-검정
    } else {
      return Colors.black87;  // 기존
    }
  }

  /// 앱 모드에 따라 Hover 색상을 반환합니다 (Light Mode)
  static Color getLightHoverColor() {
    if (isHostOnly) {
      return Color(0xFFFDEEEB);  // Host: 밝은 빨강 배경
    } else if (isRemoteOnly) {
      return Color(0xFFD6EAF8);  // Remote: 밝은 파랑 배경
    } else {
      return Color.fromARGB(255, 224, 224, 224);  // 기존
    }
  }

  /// 앱 모드에 따라 Border 색상을 반환합니다 (Light Mode)
  static Color getLightBorderColor() {
    if (isHostOnly) {
      return Color(0xFFDDDDDD);  // Host: 표준 회색
    } else if (isRemoteOnly) {
      return Color(0xFFBDC3C7);  // Remote: 중간 회색
    } else {
      return Color(0xFFCCCCCC);  // 기존
    }
  }

  // ============= 기존 상수 (Host/Remote/Dual 모드에서 공통 사용 가능) =============

  static const Color grayBg = Color(0xFFEFEFF2);
  static const Color accent = Color(0xFF00B894);  // 기존 기본값
  static const Color accent50 = Color(0x7700B894);
  static const Color accent80 = Color(0xAA00B894);
  static const Color canvasColor = Color(0xFF1A1A2E);
  static const Color border = Color(0xFFCCCCCC);
  static const Color idColor = Color(0xFF00CEC9);
  static const Color darkGray = Color.fromARGB(255, 148, 148, 148);
  static const Color cmIdColor = Color(0xFF00B894);
  static const Color dark = Colors.black87;
  static const Color button = Color(0xFF00B894);
  static const Color hoverBorder = Color(0xFF999999);

  // ============= Theme 제공 메서드 (수정) =============

  /// Light Mode ThemeData를 반환합니다
  static ThemeData get lightTheme => _buildLightTheme();

  /// Dark Mode ThemeData를 반환합니다
  static ThemeData get darkTheme => _buildDarkTheme();

  static ThemeData _buildLightTheme() {
    final primaryColor = getPrimaryColor();
    final accentColor = getAccentColor();
    final backgroundColor = getLightBackgroundColor();
    final textPrimaryColor = getLightTextPrimary();
    final hoverColor = getLightHoverColor();
    final borderColor = getLightBorderColor();

    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.light,
      hoverColor: hoverColor,
      scaffoldBackgroundColor: Colors.white,
      dialogBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        shadowColor: Colors.transparent,
        backgroundColor: Colors.white,
        foregroundColor: textPrimaryColor,
      ),
      dialogTheme: DialogTheme(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(
            width: 1,
            color: borderColor,
          ),
        ),
      ),
      scrollbarTheme: scrollbarTheme,
      inputDecorationTheme: isDesktop
          ? InputDecorationTheme(
              fillColor: backgroundColor,
              filled: true,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            )
          : null,
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 19, color: textPrimaryColor),
        titleSmall: TextStyle(fontSize: 14, color: textPrimaryColor),
        bodySmall: TextStyle(fontSize: 12, color: textPrimaryColor, height: 1.25),
        bodyMedium: TextStyle(fontSize: 14, color: textPrimaryColor, height: 1.25),
        labelLarge: TextStyle(fontSize: 16.0, color: accentColor.withOpacity(0.8)),
      ),
      cardColor: backgroundColor,
      hintColor: Color(0xFFAAAAAA),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      tabBarTheme: TabBarTheme(
        labelColor: textPrimaryColor,
      ),
      tooltipTheme: tooltipTheme(),
      splashColor: (isDesktop || isWebDesktop) ? Colors.transparent : null,
      highlightColor: (isDesktop || isWebDesktop) ? Colors.transparent : null,
      splashFactory: (isDesktop || isWebDesktop) ? NoSplash.splashFactory : null,
      textButtonTheme: (isDesktop || isWebDesktop)
          ? TextButtonThemeData(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            )
          : mobileTextButtonTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textPrimaryColor,
          side: BorderSide(color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      switchTheme: switchTheme(),
      radioTheme: radioTheme(),
      checkboxTheme: checkboxTheme,
      listTileTheme: listTileTheme,
      menuBarTheme: MenuBarThemeData(
        style: MenuStyle(
          backgroundColor: MaterialStatePropertyAll(Colors.white),
        ),
      ),
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: accentColor,
        onSecondary: Colors.white,
        background: backgroundColor,
        surface: Colors.white,
        onSurface: textPrimaryColor,
      ),
      popupMenuTheme: PopupMenuThemeData(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: (isDesktop || isWebDesktop) ? borderColor : Colors.transparent,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    ).copyWith(
      extensions: <ThemeExtension<dynamic>>[
        _buildColorThemeExtensionLight(),
        TabbarTheme.light,
      ],
    );
  }

  static ThemeData _buildDarkTheme() {
    final primaryColor = getPrimaryColor();
    final accentColor = getAccentColor();
    final backgroundColor = getDarkBackgroundColor();

    return ThemeData(
      useMaterial3: false,
      brightness: Brightness.dark,
      hoverColor: Color.fromARGB(255, 45, 46, 53),
      scaffoldBackgroundColor: backgroundColor,
      dialogBackgroundColor: backgroundColor,
      appBarTheme: AppBarTheme(
        shadowColor: Colors.transparent,
        backgroundColor: Color(0xFF1E1E1E),
        foregroundColor: Colors.white70,
      ),
      dialogTheme: DialogTheme(
        elevation: 15,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
          side: BorderSide(
            width: 1,
            color: Color(0xFF24252B),
          ),
        ),
      ),
      scrollbarTheme: scrollbarThemeDark,
      inputDecorationTheme: (isDesktop || isWebDesktop)
          ? InputDecorationTheme(
              fillColor: Color(0xFF24252B),
              filled: true,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            )
          : null,
      textTheme: const TextTheme(
        titleLarge: TextStyle(fontSize: 19),
        titleSmall: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12, height: 1.25),
        bodyMedium: TextStyle(fontSize: 14, height: 1.25),
        labelLarge: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      cardColor: Color(0xFF24252B),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      tabBarTheme: const TabBarTheme(
        labelColor: Colors.white70,
      ),
      tooltipTheme: tooltipTheme(),
      splashColor: (isDesktop || isWebDesktop) ? Colors.transparent : null,
      highlightColor: (isDesktop || isWebDesktop) ? Colors.transparent : null,
      splashFactory: (isDesktop || isWebDesktop) ? NoSplash.splashFactory : null,
      textButtonTheme: (isDesktop || isWebDesktop)
          ? TextButtonThemeData(
              style: TextButton.styleFrom(
                splashFactory: NoSplash.splashFactory,
                disabledForegroundColor: Colors.white70,
                foregroundColor: Colors.white70,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            )
          : mobileTextButtonTheme,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          disabledForegroundColor: Colors.white70,
          disabledBackgroundColor: Colors.white10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: Color(0xFF24252B),
          side: BorderSide(color: Colors.white12, width: 0.5),
          disabledForegroundColor: Colors.white70,
          foregroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
      switchTheme: switchTheme(),
      radioTheme: radioTheme(),
      checkboxTheme: checkboxTheme,
      listTileTheme: listTileTheme,
      menuBarTheme: MenuBarThemeData(
        style: MenuStyle(
          backgroundColor: MaterialStatePropertyAll(Color(0xFF121212)),
        ),
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: accentColor,
        onSecondary: Colors.black,
        background: backgroundColor,
        surface: Color(0xFF24252B),
        onSurface: Colors.white70,
      ),
      popupMenuTheme: PopupMenuThemeData(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.white24),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    ).copyWith(
      extensions: <ThemeExtension<dynamic>>[
        _buildColorThemeExtensionDark(),
        TabbarTheme.dark,
      ],
    );
  }

  static ColorThemeExtension _buildColorThemeExtensionLight() {
    final borderColor = getLightBorderColor();

    return ColorThemeExtension(
      border: borderColor,
      border2: Color(0xFFBBBBBB),
      border3: Colors.black26,
      highlight: Color(0xFFE5E5E5),
      drag_indicator: Colors.grey[800],
      shadow: Colors.black,
      errorBannerBg: Color(0xFFFDEEEB),
      me: Colors.green,
      toastBg: Colors.black.withOpacity(0.6),
      toastText: Colors.white,
      divider: Colors.black38,
    );
  }

  static ColorThemeExtension _buildColorThemeExtensionDark() {
    return ColorThemeExtension(
      border: Color(0xFF555555),
      border2: Color(0xFFE5E5E5),
      border3: Colors.white24,
      highlight: Color(0xFF3F3F3F),
      drag_indicator: Colors.grey,
      shadow: Colors.grey,
      errorBannerBg: Color(0xFF470F2D),
      me: Colors.greenAccent,
      toastBg: Colors.white.withOpacity(0.6),
      toastText: Colors.black,
      divider: Colors.white38,
    );
  }

  // ============= 기존 메서드들 (변경 없음) =============

  static const ListTileThemeData listTileTheme = ListTileThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static SwitchThemeData switchTheme() {
    return SwitchThemeData(
      splashRadius: (isDesktop || isWebDesktop) ? 0 : kRadialReactionRadius,
    );
  }

  static RadioThemeData radioTheme() {
    return RadioThemeData(
      splashRadius: (isDesktop || isWebDesktop) ? 0 : kRadialReactionRadius,
    );
  }

  static const CheckboxThemeData checkboxTheme = CheckboxThemeData(
    splashRadius: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(5)),
    ),
  );

  static const double mobileTextButtonPaddingLR = 20;

  static TextButtonThemeData mobileTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: mobileTextButtonPaddingLR),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  );

  static TooltipThemeData tooltipTheme() {
    return TooltipThemeData(
      waitDuration: Duration(seconds: 1, milliseconds: 500),
    );
  }

  static const double dialogPadding = 24;

  static EdgeInsets dialogTitlePadding({bool content = true}) {
    final double p = dialogPadding;
    return EdgeInsets.fromLTRB(p, p, p, content ? 0 : p);
  }

  static EdgeInsets dialogContentPadding({bool actions = true}) {
    final double p = dialogPadding;
    return (isDesktop || isWebDesktop)
        ? EdgeInsets.fromLTRB(p, p, p, actions ? (p - 4) : p)
        : EdgeInsets.fromLTRB(p, p, p, actions ? (p / 2) : p);
  }

  static EdgeInsets dialogActionsPadding() {
    final double p = dialogPadding;
    return (isDesktop || isWebDesktop)
        ? EdgeInsets.fromLTRB(p, 0, p, (p - 4))
        : EdgeInsets.fromLTRB(p, 0, (p - mobileTextButtonPaddingLR), (p / 2));
  }

  static EdgeInsets dialogButtonPadding = (isDesktop || isWebDesktop)
      ? EdgeInsets.only(left: dialogPadding)
      : EdgeInsets.only(left: dialogPadding / 3);

  static ScrollbarThemeData scrollbarTheme = ScrollbarThemeData(
    thickness: MaterialStateProperty.all(6),
    thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.dragged)) {
        return Colors.grey[900];
      } else if (states.contains(MaterialState.hovered)) {
        return Colors.grey[700];
      } else {
        return Colors.grey[500];
      }
    }),
    crossAxisMargin: 4,
  );

  static ScrollbarThemeData scrollbarThemeDark = scrollbarTheme.copyWith(
    thumbColor: MaterialStateProperty.resolveWith<Color?>((states) {
      if (states.contains(MaterialState.dragged)) {
        return Colors.grey[100];
      } else if (states.contains(MaterialState.hovered)) {
        return Colors.grey[300];
      } else {
        return Colors.grey[500];
      }
    }),
  );

  static ThemeMode getThemeModePreference() {
    return themeModeFromString(bind.mainGetLocalOption(key: kCommConfKeyTheme));
  }

  static Future<void> changeDarkMode(ThemeMode mode) async {
    Get.changeThemeMode(mode);
    if (desktopType == DesktopType.main || isAndroid || isIOS || isWeb) {
      if (mode == ThemeMode.system) {
        await bind.mainSetLocalOption(
            key: kCommConfKeyTheme, value: defaultOptionTheme);
      } else {
        await bind.mainSetLocalOption(
            key: kCommConfKeyTheme, value: mode.toShortString());
      }
      if (!isWeb) await bind.mainChangeTheme(dark: mode.toShortString());
      updateSystemWindowTheme();
    }
  }

  static ThemeMode currentThemeMode() {
    final preference = getThemeModePreference();
    if (preference == ThemeMode.system) {
      if (WidgetsBinding.instance.platformDispatcher.platformBrightness ==
          Brightness.light) {
        return ThemeMode.light;
      } else {
        return ThemeMode.dark;
      }
    } else {
      return preference;
    }
  }

  static ColorThemeExtension color(BuildContext context) {
    return Theme.of(context).extension<ColorThemeExtension>()!;
  }

  static TabbarTheme tabbar(BuildContext context) {
    return Theme.of(context).extension<TabbarTheme>()!;
  }

  static ThemeMode themeModeFromString(String v) {
    switch (v) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
```

---

## 3. Host 앱 UI 설계

### 3.1 홈 페이지 레이아웃 (DesktopHomePageHost)

**파일**: `flutter/lib/desktop/pages/desktop_home_page_host.dart`

**화면 구성**:
```
┌─────────────────────────────────────┐
│         ShopRemote3 Logo            │  (24px 상단 패딩)
├─────────────────────────────────────┤
│  Your Desktop                       │
│  Host-only mode - Allow incoming    │
│  connections                        │
├─────────────────────────────────────┤
│                                     │
│  Device ID                          │  (Accent Color: #E74C3C)
│  ┌─────────────────────────────────┐│
│  │ 123456789012 [복사 아이콘]      ││
│  │ Double-click to copy            ││
│  └─────────────────────────────────┘│
│                                     │
├─────────────────────────────────────┤
│  Temporary Password                 │
│  ┌─────────────────────────────────┐│
│  │ ••••••••••••    [표시/숨김]    ││
│  │ [재생성]                        ││
│  │ Auto-refresh: 60 minutes        ││
│  └─────────────────────────────────┘│
│                                     │
├─────────────────────────────────────┤
│  Connection Status                  │
│  ┌─────────────────────────────────┐│
│  │ ● Online (0 connections)        ││  (초록색 상태 표시)
│  │ ● Service Running               ││
│  │ ● Last connection: 2 hrs ago    ││
│  └─────────────────────────────────┘│
│                                     │
├─────────────────────────────────────┤
│  Permission Settings                │
│  ┌─────────────────────────────────┐│
│  │ ☑ Screen Sharing                ││
│  │ ☑ File Transfer                 ││
│  │ ☑ Clipboard Sharing             ││
│  │ ☑ Keyboard/Mouse Input          ││
│  │ ☑ Audio Streaming               ││
│  └─────────────────────────────────┘│
│                                     │
├─────────────────────────────────────┤
│  Recent Connection Log              │
│  ┌─────────────────────────────────┐│
│  │ [Connection Log List]           ││
│  │ - 2026-04-02 14:30 | Admin PC  ││
│  │ - 2026-04-02 10:15 | Office    ││
│  │ - 2026-04-01 16:45 | Manager   ││
│  │ [Show All]                      ││
│  └─────────────────────────────────┘│
│                                     │
│                          [Settings] │  (하단 좌측)
└─────────────────────────────────────┘
```

**주요 섹션**:

1. **Logo Section**: ShopRemote3 로고 표시 (상단 중앙)
2. **Title Section**: "Your Desktop" + "Host-only mode" 설명
3. **Device ID Section**:
   - 고정된 12자리 ID 표시 (monospace 폰트, 악센트 색)
   - 더블클릭으로 클립보드 복사
   - 복사 완료 토스트 메시지

4. **Password Section**:
   - 임시 비밀번호 표시/숨김 토글
   - 재생성 버튼
   - 자동 갱신 설정 표시 (분 단위)
   - 다음 갱신 시간 카운트다운

5. **Status Section**:
   - 온라인/오프라인 상태 (● 아이콘 + 상태 텍스트)
   - 서비스 실행 여부
   - 마지막 연결 시간
   - 현재 활성 연결 수

6. **Permission Settings Section**:
   - 체크박스로 각 권한 토글
   - 화면 공유
   - 파일 전송
   - 클립보드 공유
   - 키보드/마우스 입력
   - 오디오 스트리밍 (선택사항)

7. **Connection Log Section**:
   - 최근 연결 기록 목록 (최대 5개 미리보기)
   - "Show All" 링크로 전체 로그 페이지 이동
   - 각 항목: 시간 | 원격 IP | 사용자명/설명

**색상 적용**:
- Primary Action Buttons: #E74C3C (Host Red)
- Accent UI Elements: #C0392B (Host Dark Red)
- Success Status: #27AE60 (Green)
- Card Background: Light theme 시 #FFFFFF, Dark theme 시 #1E1E1E
- Border: Light theme 시 #DDDDDD, Dark theme 시 #333333

**상호작용**:
- ID 더블클릭: 클립보드 복사
- 재생성 버튼: 새 비밀번호 생성
- 토글: 권한 활성화/비활성화 (실시간 적용)
- Settings 버튼: 하단 좌측 (Floating 스타일)

### 3.2 설정 페이지 (Host 모드)

**파일**: `flutter/lib/desktop/pages/desktop_setting_page.dart` (조건부 Host 섹션)

**Host 전용 탭**:

1. **일반 설정**
   - 언어 선택 드롭다운
   - 테마 선택 (Light/Dark/System)
   - 시작 시 자동 시작 체크박스
   - 최소화 시 트레이로 이동 체크박스

2. **보안 설정**
   - 비밀번호 자동 재생성 체크박스
   - 재생성 주기 슬라이더 (10-120분)
   - 원격 접속 시 확인 메시지 체크박스
   - 접속 로그 저장 기간 선택 (1주-12개월)

3. **서버 설정**
   - 기본 서버 선택 (ai.ilv.co.kr 기본값)
   - 커스텀 서버 입력 필드
   - 암호화 레벨 선택 (Standard/High)

4. **접속 로그**
   - 로그 자동 정리 체크박스
   - 로그 보존 기간 설정
   - "로그 삭제" 버튼

### 3.3 앱 창 크기 및 레이아웃

**기본 창 크기**: 360px (너비) x 600px (높이)
**최소 크기**: 320px x 500px
**홈 페이지**: 고정 크기 (리사이징 불가)
**설정 페이지**: 리사이징 가능

---

## 4. Remote 앱 UI 설계

### 4.1 홈 페이지 레이아웃 (DesktopHomePageRemote)

**파일**: `flutter/lib/desktop/pages/desktop_home_page_remote.dart` (신규 생성)

**화면 구성**:
```
┌──────────────────────────────┬──────────────────────────────┐
│  SIDEBAR (Address Book)      │  MAIN PANEL (Connection)     │
│ ┌────────────────────────────┤                              │
│ │ ◆ Address Book             │ ShopRemote3 Remote           │
│ │                            │                              │
│ │ [+ New Connection]         │ Device ID                    │
│ │                            │ ┌─────────────────────────┐  │
│ │ ★ Favorites                │ │ [                     ] │  │
│ │ • Store A (POS-1)         │ │  Connect                │  │
│ │ • Store B (POS-2)         │ └─────────────────────────┘  │
│ │ • Office (Server)         │                              │
│ │                            │ Recent Connections           │
│ │ ☞ All Devices             │ ┌─────────────────────────┐  │
│ │ • Main Office             │ │ • Store A (123456)      │  │
│ │ • Branch (East)           │ │ • Office (234567)       │  │
│ │ • Warehouse               │ │ • Manager (345678)      │  │
│ │ • Admin PC                │ └─────────────────────────┘  │
│ │                            │                              │
│ │ [⚙ Settings] [ℹ About]    │ Active Sessions (Tabs)       │
│ │                            │ ┌─────────────────────────┐  │
│ │                            │ │ [+] Home | Session 1 | x│  │
│ │                            │ │     [Remote View Area] │  │
│ │                            │ │                         │  │
│ │                            │ │                         │  │
│ │                            │ │                         │  │
│ │                            │ │                         │  │
│ │                            │ └─────────────────────────┘  │
└──────────────────────────────┴──────────────────────────────┘
```

**주요 섹션**:

1. **Header**: "ShopRemote3 Remote" 타이틀

2. **Device ID Input Section**:
   - 큰 입력 필드 (ID 또는 주소 입력)
   - "Connect" 버튼 (Primary, #2980B9)
   - 입력 옆에 최근 목록 드롭다운

3. **Recent Connections Panel**:
   - 최근 연결 목록 (최대 5개)
   - 각 항목: 아이콘 + 이름 + ID
   - 클릭으로 빠른 연결

4. **Sidebar (Left Panel)**:
   - **Address Book 섹션**:
     - "New Connection" 버튼
     - 즐겨찾기 (★ 마크) 목록
     - 모든 디바이스 목록
   - **Settings/About** 버튼 (하단)

5. **Main Panel (Center/Right)**:
   - 탭 바: Home | Active Session Tabs
   - 원격 뷰어 영역
   - 다중 탭으로 여러 세션 동시 관리

**색상 적용**:
- Primary Action Buttons: #2980B9 (Remote Blue)
- Accent UI Elements: #3498DB (Remote Light Blue)
- Sidebar Background: Light theme 시 #F5F8FB, Dark theme 시 #1A202C
- Main Panel Background: Light theme 시 #FFFFFF, Dark theme 시 #1E1E1E
- Border: Light theme 시 #BDC3C7, Dark theme 시 #2D3748

**상호작용**:
- ID 입력 + Enter 또는 Connect 버튼: 연결 시작
- 최근 항목 클릭: 즉시 연결
- 주소록 항목 우클릭: 편집/삭제 메뉴
- 탭 우클릭: 탭 닫기/다른 탭 닫기 옵션

### 4.2 설정 페이지 (Remote 모드)

**파일**: `flutter/lib/desktop/pages/desktop_setting_page.dart` (조건부 Remote 섹션)

**Remote 전용 탭**:

1. **일반 설정**
   - 언어 선택 드롭다운
   - 테마 선택 (Light/Dark/System)
   - 자동 로그인 체크박스
   - 연결 해제 시 창 닫기 체크박스

2. **디스플레이 설정**
   - 리모트 뷰 스케일 (Fit/Fill/100%/150%/200%)
   - 고품질 모드 (전역 설정)
   - 마우스 포인터 표시 체크박스
   - 전체화면 단축키 설정

3. **전송 설정**
   - 파일 다운로드 위치 선택
   - 클립보드 동기화 활성화
   - 자동 파일 수용 (Ask/Always/Never)

4. **보안 설정**
   - 서버 증명서 검증 체크박스
   - 저장된 암호 관리
   - 세션 암호화 설정

### 4.3 주소록 관리 (Address Book)

**파일**: `flutter/lib/desktop/pages/address_book_page.dart` (신규 또는 수정)

**기능**:
- 즐겨찾기 추가/제거
- 그룹별 정렬 (즐겨찾기, 최근, 모두)
- 검색 기능
- 주소 편집 및 이름 변경
- 다중 선택 및 삭제

### 4.4 원격 뷰어 (Remote Viewer)

**파일**: `flutter/lib/desktop/pages/remote_view_page.dart` (기존, Remote 모드에서만 표시)

**기능**:
- 원격 데스크톱 표시
- 마우스/키보드 입력 처리
- 파일 드래그앤드롭 수신
- 클립보드 동기화
- 전체화면 지원

### 4.5 파일 전송 UI

**파일**: `flutter/lib/desktop/pages/file_transfer_page.dart` (기존, Remote 모드에서만 표시)

**기능**:
- 파일 브라우저 (로컬 + 원격)
- 업로드/다운로드 진행률 표시
- 드래그앤드롭 지원
- 파일 삭제/이름변경
- 즐겨찾기 폴더

---

## 5. 공통 UI 요소

### 5.1 앱 바 (App Bar) / 타이틀 바

**Host 앱**:
- 배경색: 앱 배경색과 동일 또는 약간 어두운 색
- 텍스트: "ShopRemote3 Host" 또는 로고만 표시
- 오른쪽: 최소화, 최대화, 닫기 버튼 (Windows/Linux)

**Remote 앱**:
- 배경색: 앱 배경색과 동일
- 텍스트: "ShopRemote3 Remote" 또는 로고
- 오른쪽: 최소화, 최대화, 닫기 버튼

**색상**:
- Host: Red theme (Primary: #E74C3C)
- Remote: Blue theme (Primary: #2980B9)

### 5.2 설정 페이지 공통 요소

**구조**:
```
┌──────────────────────────────────┐
│ ⚙ Settings                   [←] │
├──────────────────────────────────┤
│ [General] [Security] [About]     │
├──────────────────────────────────┤
│                                  │
│ [Settings Content by Tab]        │
│                                  │
│                      [OK] [Cancel]│
└──────────────────────────────────┘
```

**공통 탭**:
1. **General**: 언어, 테마, 시작 옵션
2. **About**: 버전, 라이선스, 피드백

**Host 전용 탭**: Security (비밀번호 설정)
**Remote 전용 탭**: Display, Transfer

**버튼**:
- OK: 변경사항 저장 후 닫기 (#E74C3C for Host, #2980B9 for Remote)
- Cancel: 변경사항 취소 후 닫기

### 5.3 About 다이얼로그

**내용**:
```
ShopRemote3 [Host/Remote]
Version: 3.0.1
Build: 2026-04-02
GitHub: ccaplee/shopremote3

[Website] [License] [Feedback]
```

**색상**: 각 앱의 Primary Color 사용

### 5.4 공통 시스템 UI 요소

| 요소 | Host (Red) | Remote (Blue) |
|------|-----------|---------------|
| Primary Button | #E74C3C | #2980B9 |
| Secondary Button | #C0392B | #3498DB |
| Success Status | #27AE60 | #27AE60 |
| Warning | #F39C12 | #F39C12 |
| Error | #E74C3C | #E74C3C |
| Info | #3498DB | #3498DB |
| Disabled | #CCCCCC | #CCCCCC |

---

## 6. 아이콘 및 브랜딩

### 6.1 앱 아이콘 설계

**Host 앱 아이콘**:
- **컨셉**: 빨간 방패 + 모니터 이미지
- **주요색**: #E74C3C (Red)
- **보조색**: #C0392B (Dark Red)
- **디자인**:
  - 중앙에 모니터 실루엣
  - 배경에 방패 형태
  - 하단 모서리에 작은 "H" 배지 (Host)

**크기**:
- 512x512px (원본)
- 256x256px (사용)
- 128x128px (작은 아이콘)
- 32x32px (윈도우 타이틀바)
- 16x16px (Favicon)

**Remote 앱 아이콘**:
- **컨셉**: 파란 화살표 + 컨트롤러/손가락
- **주요색**: #2980B9 (Blue)
- **보조색**: #3498DB (Light Blue)
- **디자인**:
  - 중앙에 오른쪽을 가리키는 화살표
  - 배경에 컨트롤러 형태 또는 손가락
  - 하단 모서리에 작은 "R" 배지 (Remote)

**크기**: Host와 동일

### 6.2 스플래시 스크린 설계

**Host 스플래시**:
```
┌─────────────────────────────┐
│                             │
│        [Host Icon]          │
│      ShopRemote3            │
│        HOST APP             │
│                             │
│      [Loading Progress]     │
│                             │
│   Version 3.0.1             │
└─────────────────────────────┘
```

**Remote 스플래시**:
```
┌─────────────────────────────┐
│                             │
│       [Remote Icon]         │
│      ShopRemote3            │
│      REMOTE APP             │
│                             │
│      [Loading Progress]     │
│                             │
│   Version 3.0.1             │
└─────────────────────────────┘
```

**배경색**:
- Host: Light: #FAFAFA / Dark: #121212
- Remote: Light: #FAFAFA / Dark: #0F1419

**진행 표시기**: 각 앱의 Primary Color 사용

### 6.3 윈도우 타이틀 포맷

**Host 앱**:
- 기본: "ShopRemote3 Host"
- 접속 시: "ShopRemote3 Host - ID: 123456"
- 설정 중: "ShopRemote3 Host - Settings"

**Remote 앱**:
- 기본: "ShopRemote3 Remote"
- 연결 중: "ShopRemote3 Remote - Connecting..."
- 연결됨: "ShopRemote3 Remote - [ID: 123456]"
- 파일 전송: "ShopRemote3 Remote - File Transfer"

---

## 7. Flutter 위젯 체크리스트

### 7.1 테마 인식 위젯 (Theme-Aware Widgets)

모든 위젯은 `isHostOnly` / `isRemoteOnly` 플래그와 현재 테마를 고려하여 색상을 적용해야 합니다.

#### 7.1.1 AppBar / Title Bar
```dart
AppBar(
  backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
  foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
  elevation: 0,
  title: Text(isHostOnly ? 'ShopRemote3 Host' : 'ShopRemote3 Remote'),
)
```

**변경 사항**:
- backgroundColor: `getPrimaryColor().withOpacity(0.05)` 또는 배경색 사용
- foregroundColor: Host 앱에선 #E74C3C, Remote 앱에선 #2980B9 고려

#### 7.1.2 ElevatedButton
```dart
ElevatedButton(
  onPressed: () {},
  style: ElevatedButton.styleFrom(
    backgroundColor: MyTheme.getPrimaryColor(),
    foregroundColor: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  child: Text('Connect'),
)
```

**적용 위치**:
- DesktopHomePageHost: "Regenerate", "Refresh", "Settings"
- DesktopHomePageRemote: "Connect", "Add to Address Book"
- 모든 설정 페이지: "OK", "Apply", "Save"

#### 7.1.3 OutlinedButton
```dart
OutlinedButton(
  onPressed: () {},
  style: OutlinedButton.styleFrom(
    side: BorderSide(color: MyTheme.getLightBorderColor()),
    foregroundColor: MyTheme.getLightTextPrimary(),
  ),
  child: Text('Cancel'),
)
```

**적용 위치**:
- 모든 다이얼로그: "Cancel", "No", "Close"
- 설정 페이지: "Reset to Default"

#### 7.1.4 TextButton
```dart
TextButton(
  onPressed: () {},
  child: Text('More'),
)
```

**적용 위치**:
- 라벨 텍스트: "Show All", "Edit", "Delete"
- 다이얼로그: "Learn More", "Help"

#### 7.1.5 Card / Container
```dart
Card(
  color: Theme.of(context).colorScheme.surface,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
    side: BorderSide(color: MyTheme.color(context).border!),
  ),
  child: Padding(
    padding: EdgeInsets.all(12),
    child: Column(...),
  ),
)
```

**적용 위치**:
- ID Section (DesktopHomePageHost)
- Password Section (DesktopHomePageHost)
- Status Section (DesktopHomePageHost)
- Permission Settings (DesktopHomePageHost)
- Connection Log Items

**색상 규칙**:
- Host Light: border #DDDDDD
- Host Dark: border #333333
- Remote Light: border #BDC3C7
- Remote Dark: border #2D3748

#### 7.1.6 Text 스타일
```dart
Text(
  'Device ID',
  style: Theme.of(context).textTheme.titleLarge?.copyWith(
    color: MyTheme.getLightTextPrimary(),
  ),
)
```

**적용 위치**:
- 모든 라벨 텍스트
- 제목 (titleLarge, titleSmall)
- 본문 (bodyLarge, bodyMedium, bodySmall)
- 보조 텍스트 (hint, caption 역할의 텍스트)

#### 7.1.7 Icon
```dart
Icon(
  Icons.check_circle,
  color: MyTheme.getPrimaryColor(),
  size: 24,
)
```

**적용 위치**:
- 상태 표시 아이콘 (●)
- 버튼 아이콘
- 리스트 아이콘
- 상태 배지

#### 7.1.8 Divider
```dart
Divider(
  color: MyTheme.color(context).divider,
  height: 1,
  thickness: 1,
)
```

**적용 위치**:
- 섹션 구분선
- 리스트 아이템 구분선
- 탭 바 하단

#### 7.1.9 TextField / Input
```dart
TextField(
  decoration: InputDecoration(
    filled: true,
    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: MyTheme.getLightBorderColor(),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        color: MyTheme.getPrimaryColor(),
        width: 2,
      ),
    ),
  ),
)
```

**적용 위치**:
- DesktopHomePageRemote: Device ID 입력 필드
- Address Book: 주소/이름 입력
- Settings: 모든 텍스트 입력

#### 7.1.10 Checkbox
```dart
Checkbox(
  value: isChecked,
  onChanged: (value) {},
  activeColor: MyTheme.getPrimaryColor(),
  checkColor: Colors.white,
)
```

**적용 위치**:
- Permission Settings (DesktopHomePageHost)
- Settings Page (모든 옵션)

#### 7.1.11 Switch
```dart
Switch(
  value: isEnabled,
  onChanged: (value) {},
  activeColor: MyTheme.getPrimaryColor(),
)
```

**적용 위치**:
- Settings Page: 토글 옵션

#### 7.1.12 ListTile
```dart
ListTile(
  title: Text('Item Title'),
  subtitle: Text('Subtitle'),
  leading: Icon(Icons.device_hub),
  trailing: Icon(Icons.arrow_forward),
  onTap: () {},
  tileColor: Theme.of(context).colorScheme.surface,
  shape: RoundedRectangleBorder(
    side: BorderSide(color: MyTheme.color(context).border!),
    borderRadius: BorderRadius.circular(8),
  ),
)
```

**적용 위치**:
- Address Book 목록
- Connection Log 목록
- Recent Connections 목록
- Settings 페이지 그룹

#### 7.1.13 Dialog
```dart
showDialog(
  context: context,
  builder: (context) => AlertDialog(
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    title: Text('Confirm'),
    content: Text('Are you sure?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context, false),
        child: Text('Cancel'),
      ),
      ElevatedButton(
        onPressed: () => Navigator.pop(context, true),
        child: Text('Yes'),
      ),
    ],
  ),
)
```

**적용 위치**:
- 확인 다이얼로그
- 입력 다이얼로그
- 오류 다이얼로그

#### 7.1.14 SnackBar / Toast
```dart
ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text('Copied to clipboard'),
    backgroundColor: MyTheme.color(context).toastBg,
    duration: Duration(seconds: 2),
  ),
)
```

**적용 위치**:
- ID 복사 완료
- 비밀번호 재생성 완료
- 파일 전송 완료/실패

#### 7.1.15 Scrollbar
```dart
ScrollbarTheme(
  data: MyTheme.scrollbarTheme,  // Light mode
  // 또는 MyTheme.scrollbarThemeDark for dark mode
  child: ListView(...),
)
```

**적용 위치**:
- Connection Log 리스트
- Address Book 리스트
- Settings 페이지

### 7.2 테마 색상 참조 방법

#### Light Mode에서 동적 색상 사용
```dart
// Context를 통한 현재 테마의 색상 사용
final backgroundColor = Theme.of(context).colorScheme.background;
final textColor = Theme.of(context).textTheme.titleLarge?.color;
final borderColor = MyTheme.color(context).border;

// 앱별 기본색 사용
final primaryColor = MyTheme.getPrimaryColor();  // Host: Red, Remote: Blue
final accentColor = MyTheme.getAccentColor();
```

#### Dark Mode에서의 색상
```dart
// Dark mode는 자동으로 테마 시스템에서 처리
// (별도의 라이트/다크 색상 제공 불필요)
```

### 7.3 위젯 변경 체크리스트

| 위젯 | 파일 | 변경 사항 |
|------|------|---------|
| AppBar | 모든 페이지 | 색상 동적 적용 |
| ElevatedButton | 모든 페이지 | Primary Color 사용 |
| OutlinedButton | 다이얼로그, 설정 | Border/Text Color 동적 |
| TextButton | 라벨 텍스트 | 포그라운드 색상 동적 |
| Card | Section Cards | Surface Color + Border 동적 |
| Text | 모든 텍스트 | Text Color 동적 |
| Icon | 상태 표시 | Color 동적 |
| Divider | Section 구분 | Color 동적 |
| TextField | 입력 필드 | Border/Fill Color 동적 |
| Checkbox | 권한 설정 | Active Color 동적 |
| Switch | 토글 옵션 | Active Color 동적 |
| ListTile | 목록 | Tile Color + Border 동적 |
| Dialog | 다이얼로그 | Background Color 동적 |
| SnackBar | 알림 | Background Color 동적 |

---

## 8. 구현 전략

### 8.1 Phase 1: 색상 시스템 (1-2주)

1. `common.dart`의 MyTheme 클래스 수정
   - `getPrimaryColor()` 등 동적 색상 메서드 추가
   - Light/Dark 테마 빌더 함수 분리
   - Host/Remote 모드별 ColorThemeExtension 구성

2. 단위 테스트
   - `isHostOnly = true` 시 색상 검증
   - `isRemoteOnly = true` 시 색상 검증
   - Light/Dark 모드 전환 검증

### 8.2 Phase 2: Host 앱 UI (2-3주)

1. `DesktopHomePageHost` 완성
   - Logo, Title, ID, Password, Status 섹션 구현
   - Permission Settings 섹션 구현
   - Connection Log 섹션 구현

2. Host 설정 페이지
   - General, Security, Server 탭 추가
   - 색상 적용

### 8.3 Phase 3: Remote 앱 UI (2-3주)

1. `DesktopHomePageRemote` 신규 생성
   - ID Input 섹션
   - Recent Connections 섹션
   - Address Book 사이드바

2. Remote 설정 페이지
   - Display, Transfer, Security 탭 추가

### 8.4 Phase 4: 공통 요소 & 통합 (1-2주)

1. 모든 위젯 색상 적용
2. 테마 전환 테스트
3. 크로스 플랫폼 테스트 (Windows, Linux, macOS)

---

## 9. 주의사항 및 가이드라인

### 9.1 색상 사용 규칙

1. **절대 사용하면 안 되는 것**:
   - 하드코딩된 색상 (예: `Color(0xFF00B894)`)
   - Material Colors (예: `Colors.red`, `Colors.blue`)
   - 기존 `MyTheme.accent`

2. **반드시 사용해야 하는 것**:
   - `MyTheme.getPrimaryColor()`
   - `MyTheme.getAccentColor()`
   - `Theme.of(context).colorScheme.*`
   - `Theme.of(context).textTheme.*`
   - `MyTheme.color(context).*`

3. **선택사항**:
   - 상태 색상 (#27AE60 success, #F39C12 warning 등)은 공통으로 사용 가능

### 9.2 레이아웃 일관성

1. **Host 앱**:
   - 단일 컬럼 레이아웃 (너비 320-360px)
   - Scrollable 섹션들
   - Settings 버튼은 하단 고정

2. **Remote 앱**:
   - 좌측 사이드바 + 중앙 메인 패널
   - 적응형 레이아웃
   - 탭 바로 여러 세션 관리

### 9.3 다크모드 고려사항

1. **배경색**: Light #FAFAFA → Dark #121212 (Host) 또는 #0F1419 (Remote)
2. **텍스트색**: Light #2C3E50/#1F3A5F → Dark #FAFAFA
3. **아이콘색**: Light dark gray → Dark light gray
4. **경계선색**: Light light gray → Dark dark gray

### 9.4 테스트 항목

1. **색상 검증**:
   - Light Mode 전체 스크린샷
   - Dark Mode 전체 스크린샷
   - Host 앱 색상 확인
   - Remote 앱 색상 확인

2. **접근성**:
   - 색상 대비 비율 (WCAG AA 이상)
   - 색상 시력 이상자 고려

3. **크로스플랫폼**:
   - Windows 10/11
   - macOS 12+
   - Linux (Ubuntu 20.04+)

---

## 10. 참고 자료

### 10.1 파일 목록

**수정/생성 필요 파일**:
- `flutter/lib/common.dart` (MyTheme 클래스 수정)
- `flutter/lib/desktop/pages/desktop_home_page_host.dart` (기존 파일)
- `flutter/lib/desktop/pages/desktop_setting_page.dart` (Host 섹션 추가)
- `flutter/lib/desktop/pages/desktop_home_page_remote.dart` (신규)
- `flutter/lib/desktop/pages/desktop_setting_page_remote.dart` (신규)
- `flutter/lib/desktop/pages/address_book_page.dart` (신규 또는 기존 수정)

**리소스 생성 필요**:
- `flutter/assets/host_icon.png` (각 크기별)
- `flutter/assets/remote_icon.png` (각 크기별)
- `flutter/assets/host_splash.png`
- `flutter/assets/remote_splash.png`

### 10.2 Color Code Reference

**Host 앱 (Red)**:
- Primary: #E74C3C
- Dark: #C0392B
- Light: #F5A9A3

**Remote 앱 (Blue)**:
- Primary: #2980B9
- Dark: #1F3A5F
- Light: #3498DB

**공통 상태색**:
- Success: #27AE60
- Warning: #F39C12
- Error: #E74C3C
- Info: #3498DB

---

**문서 버전**: 1.0
**최종 수정**: 2026-04-02
**담당자**: Design Agent for ShopRemote3
