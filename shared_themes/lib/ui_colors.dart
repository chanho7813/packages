/// ui_colors.dart
///
/// 역할: 앱 전체 UI 요소의 색상을 테마에 따라 중앙 집중식으로 관리하는 시스템.
///       UIColors 클래스는 AppColorTheme 인스턴스를 받아 각 UI 역할별 색상을 게터로 제공한다.
///       UIColorsExtension은 context.uiColors로 현재 테마 색상에 접근하게 해준다.
///
/// 사용법: 앱 시작 시 SharedThemesConfig.currentThemeGetter를 등록해야 한다.
///   SharedThemesConfig.currentThemeGetter = () => dataService.getCurrentTheme();
import 'package:flutter/material.dart';
import 'color_themes.dart';

/// SharedThemesConfig
///
/// 역할: 각 앱이 시작할 때 테마 정보를 공유 패키지에 등록하는 설정 클래스.
class SharedThemesConfig {
  /// 현재 테마 이름을 반환하는 함수. 앱 시작 시 등록해야 한다.
  static String Function() currentThemeGetter = () => 'white';
}

/// UIColors
///
/// 역할: AppColorTheme을 기반으로 앱 전체 UI 색상을 역할별 게터로 노출한다.
/// 사용: context.uiColors 확장으로 어디서든 접근 가능
class UIColors {
  /// 기반 테마
  final AppColorTheme theme;

  const UIColors(this.theme);

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 텍스트 색상
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  /// 페이지 제목
  Color get pageTitle => theme.primary;

  /// 페이지 부제목
  Color get pageSubtitle => Colors.grey[500]!;

  /// 섹션 헤더
  Color get sectionHeader => theme.primary;

  /// 섹션 카운트
  Color get sectionCount => Colors.grey[400]!;

  /// 카드 제목
  Color get cardTitle => theme.primary;

  /// 카드 본문 텍스트
  Color get cardBodyText => const Color(0xFF2C3E50);

  /// 카드 참조 텍스트
  Color get cardReference => Colors.grey[700]!;

  /// 카드 부제목/참조 텍스트
  Color get cardSubtitle => Colors.grey[600]!;

  /// 칩 텍스트
  Color get chipText => Colors.grey[600]!;

  /// 빈 상태 안내 텍스트
  Color get emptyStateText => Colors.grey[500]!;

  /// 비활성화된 텍스트
  Color get disabledText => Colors.grey[400]!;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 배경 색상
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  /// 페이지 배경
  Color get pageBackground => theme.background;

  /// 카드 배경
  Color get cardBackground => theme.cardBackground;

  /// 아이콘 배경
  Color get iconBackground => Colors.grey[100]!;

  /// 칩 배경
  Color get chipBackground => Colors.grey[100]!;

  /// 선택된 칩 배경
  Color get chipBackgroundSelected => theme.primary;

  /// 카테고리 칩 배경 (비선택)
  Color get categoryChipBackground => theme.cardBackground;

  /// 카테고리 칩 배경 (선택)
  Color get categoryChipBackgroundSelected => theme.primary;

  /// 뱃지 배경
  Color badgeBackground(Color baseColor) => baseColor.withValues(alpha: 0.1);

  /// 카테고리 칩 카운트 뱃지 배경 (선택)
  Color get categoryChipCountBadgeSelected =>
      Colors.white.withValues(alpha: 0.2);

  /// 카테고리 칩 카운트 뱃지 배경 (비선택)
  Color get categoryChipCountBadgeUnselected => Colors.grey[100]!;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 테두리 색상
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  /// 카드 테두리
  Color get cardBorder => Colors.grey[200]!;

  /// 카테고리 칩 테두리 (비선택)
  Color get categoryChipBorder => Colors.grey[300]!;

  /// 카테고리 칩 테두리 (선택)
  Color get categoryChipBorderSelected => theme.primary;

  /// 선택된 테마 옵션 테두리
  Color get selectedThemeBorder => theme.primary;

  /// 비선택 테마 옵션 테두리
  Color get unselectedThemeBorder => Colors.grey[200]!;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 인터랙티브 요소 색상
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  /// 선택 아이콘 (체크 원, 선택됨)
  Color get selectionIconSelected => theme.primary;

  /// 선택 아이콘 (빈 원, 비선택)
  Color get selectionIconUnselected => Colors.grey[300]!;

  /// 뱃지 텍스트
  Color get badgeText => theme.primary;

  /// 카테고리 칩 텍스트 (선택)
  Color get categoryChipTextSelected => Colors.white;

  /// 카테고리 칩 텍스트 (비선택)
  Color get categoryChipTextUnselected => Colors.grey[700]!;

  /// 카테고리 칩 카운트 텍스트 (선택)
  Color get categoryChipCountTextSelected => Colors.white;

  /// 카테고리 칩 카운트 텍스트 (비선택)
  Color get categoryChipCountTextUnselected => Colors.grey[600]!;

  /// 페이지 헤더 아이콘 색상
  Color get pageHeaderIconColor => Colors.grey[600]!;

  /// 빈 상태 아이콘
  Color get emptyStateIcon => theme.primary;

  /// 빈 상태 아이콘 배경
  Color emptyStateIconBackground() => theme.primary.withValues(alpha: 0.08);

  /// 설정 리스트 타일 트레일링 아이콘
  Color get listTileTrailingIcon => Colors.grey;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 그림자
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  /// 카드 그림자
  List<BoxShadow> get cardShadows => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 8,
      offset: const Offset(0, 2),
    ),
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.06),
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];

  /// 팝업 그림자
  List<BoxShadow> get popupShadows => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.12),
      blurRadius: 24,
      offset: const Offset(0, 4),
    ),
  ];

  /// 작은 요소 그림자
  List<BoxShadow> get circleShadows => [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 4,
      offset: const Offset(0, 2),
    ),
  ];

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 상수 색상 (테마 무관)
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
  // 회색 음영
  // ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

  static Color get grey100 => Colors.grey[100]!;
  static Color get grey200 => Colors.grey[200]!;
  static Color get grey300 => Colors.grey[300]!;
  static Color get grey400 => Colors.grey[400]!;
  static Color get grey500 => Colors.grey[500]!;
  static Color get grey600 => Colors.grey[600]!;
  static Color get grey700 => Colors.grey[700]!;
}

/// UIColorsExtension
///
/// 역할: BuildContext에 uiColors 게터를 확장하여
///       위젯 어디서든 context.uiColors로 현재 테마의 UIColors에 접근할 수 있게 한다.
extension UIColorsExtension on BuildContext {
  UIColors get uiColors {
    final themeName = SharedThemesConfig.currentThemeGetter();
    final theme = AppColorThemes.getByName(themeName) ?? AppColorThemes.white;
    return theme.uiColors;
  }
}
