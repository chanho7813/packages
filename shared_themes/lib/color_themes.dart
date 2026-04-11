/// color_themes.dart
///
/// 역할: 앱 전체 색상 테마를 정의하고 관리한다.
///       AppColorTheme은 단일 테마의 색상 팔레트와 ThemeData 생성 로직을 담고,
///       AppColorThemes는 사전 정의된 6개 테마 상수와 조회 유틸리티를 제공한다.
/// 주요 클래스: AppColorTheme, AppColorThemes
/// 연관 파일: ui_colors.dart
import 'package:flutter/material.dart';
import 'ui_colors.dart';

/// AppColorTheme
///
/// 역할: 하나의 색상 테마를 구성하는 모든 색상 값과
///       해당 테마 기반의 ThemeData, UIColors를 생성하는 팩토리 역할.
/// 사용: AppColorThemes의 정적 상수로 선언되며, DataService를 통해 현재 테마로 선택됨
class AppColorTheme {
  /// 테마 식별자 (예: 'brown', 'green', 'white' 등)
  final String name;

  /// 테마 한국어 설명 (설정 화면 표시용)
  final String description;

  /// 테마 영어 설명 (설정 화면 영문 표시용)
  final String descriptionEn;

  /// 주 색상 — 제목, 아이콘, 선택된 요소 등 가장 두드러지는 색상
  /// 암송 앱에서 사용처:
  ///   - AppBar 제목/아이콘
  ///   - 버튼 (ElevatedButton, TextButton)
  ///   - 주요 텍스트 (헤더, 강조 표시)
  ///   - ColorScheme.onSurface (카드 내 기본 텍스트)
  final Color primary;

  /// 강조 색상 — 선택/활성 상태의 강조 색상
  /// 암송 앱에서 사용처:
  ///   - 하단 내비게이션 바 선택된 아이콘
  ///   - 카테고리 칩 활성화 상태
  ///   - 토글/라디오 버튼 선택 상태
  final Color accent;

  /// 보조 색상 — 부드러운 강조 색상
  /// 암송 앱에서 사용처:
  ///   - ColorScheme.secondary (Material 컴포넌트 기본값)
  ///   - 장기 예약 구성요소
  ///   - 배지/라벨 배경색
  final Color secondary;

  /// 앱 배경 색상 — 전체 앱의 기본 배경
  /// 암송 앱에서 사용처:
  ///   - Scaffold 배경 (모든 페이지의 기본 배경)
  ///   - AppBar 배경
  ///   - ListView/ScrollView 배경
  final Color background;

  /// 카드 배경 색상 — 콘텐츠 카드와 바의 배경
  /// 암송 앱에서 사용처:
  ///   - 성경책/구절 카드 배경
  ///   - 암송 진행률 카드 배경
  ///   - 하단 내비게이션 바 배경
  ///   - 다이얼로그/모달 배경
  final Color cardBackground;

  /// primary 위에 표시되는 텍스트/아이콘 색상 (기본: 흰색)
  /// 암송 앱에서 사용처:
  ///   - 버튼 텍스트/아이콘 (primary 배경 위)
  ///   - AppBar 아이콘 (primary 배경 위)
  final Color onPrimary;

  /// secondary 위에 표시되는 텍스트/아이콘 색상 (기본: 흰색)
  /// 암송 앱에서 사용처:
  ///   - secondary 배경 위의 텍스트/아이콘
  final Color onSecondary;

  /// 하단 내비게이션 바 비선택 아이콘 색상 (기본: 회색)
  /// 암송 앱에서 사용처:
  ///   - 하단 내비게이션 바 비활성 아이콘
  ///   - 비활성 탭 라벨 텍스트
  final Color unselectedItem;

  const AppColorTheme({
    required this.name,
    required this.description,
    required this.descriptionEn,
    required this.primary,
    required this.accent,
    required this.secondary,
    required this.background,
    required this.cardBackground,
    this.onPrimary = Colors.white,
    this.onSecondary = Colors.white,
    this.unselectedItem = const Color(0xFFBDBDBD),
  });

  /// toThemeData
  ///
  /// 역할: 이 테마의 색상 값을 기반으로 Flutter ThemeData를 생성한다.
  ThemeData toThemeData() {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.light(
        primary: primary,
        onPrimary: onPrimary,
        secondary: secondary,
        onSecondary: onSecondary,
        surface: background,
        onSurface: primary,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: background,
        foregroundColor: primary,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cardBackground,
        selectedItemColor: accent,
        unselectedItemColor: unselectedItem,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: cardBackground,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: onPrimary,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary),
      ),
    );
  }

  /// uiColors
  ///
  /// 역할: 이 테마를 기반으로 UIColors 인스턴스를 생성한다.
  UIColors get uiColors => UIColors(this);
}

/// AppColorThemes
///
/// 역할: 앱에서 사용 가능한 6개 테마를 정적 상수로 정의하고,
///       전체 목록(all)과 이름 기반 조회(getByName) 유틸리티를 제공한다.
class AppColorThemes {
  static const brown = AppColorTheme(
    name: 'brown',
    description: '따뜻한 베이지/브라운',
    descriptionEn: 'Warm Beige / Brown',
    primary: Color(0xFF5D4E37),
    accent: Color(0xFFD4A574),
    secondary: Color(0xFFA0826D),
    background: Colors.white,
    cardBackground: Colors.white,
  );

  static const green = AppColorTheme(
    name: 'green',
    description: '심플 그린/올리브',
    descriptionEn: 'Simple Green / Olive',
    primary: Color(0xFF2D5016),
    accent: Color(0xFF7CB342),
    secondary: Color(0xFF9CCC65),
    background: Colors.white,
    cardBackground: Colors.white,
  );

  static const purple = AppColorTheme(
    name: 'purple',
    description: '우아한 퍼플/인디고',
    descriptionEn: 'Elegant Purple / Indigo',
    primary: Color(0xFF8E6BA8),
    accent: Color(0xFFAB47BC),
    secondary: Color(0xFFBA68C8),
    background: Colors.white,
    cardBackground: Colors.white,
  );

  static const indigo = AppColorTheme(
    name: 'indigo',
    description: '모던 다크블루/틸',
    descriptionEn: 'Modern Dark Blue / Teal',
    primary: Color(0xFF1A237E),
    accent: Color(0xFF26A69A),
    secondary: Color(0xFF4DB6AC),
    background: Colors.white,
    cardBackground: Colors.white,
  );

  static const slate = AppColorTheme(
    name: 'slate',
    description: '부드러운 슬레이트 블루',
    descriptionEn: 'Soft Slate Blue',
    primary: Color(0xFF455A64),
    accent: Color(0xFF607D8B),
    secondary: Color(0xFF78909C),
    background: Colors.white,
    cardBackground: Colors.white,
  );

  static const white = AppColorTheme(
    name: 'white',
    description: '깔끔한 화이트',
    descriptionEn: 'Clean White',
    primary: Color(0xFF1A1A1A),
    accent: Color(0xFF616161),
    secondary: Colors.white,
    background: Colors.white,
    cardBackground: Colors.white,
  );

  /// 모든 테마 목록
  static const List<AppColorTheme> all = [
    white,
    brown,
    green,
    purple,
    indigo,
    slate,
  ];

  /// getByName — 테마 이름으로 조회
  static AppColorTheme? getByName(String name) {
    try {
      return all.firstWhere((theme) => theme.name == name);
    } catch (e) {
      return null;
    }
  }
}
