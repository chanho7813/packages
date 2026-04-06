/// shared_themes — 공유 테마 패키지
///
/// 암송/기도 앱에서 공통으로 사용하는 색상 테마 시스템.
/// AppColorTheme, AppColorThemes, UIColors를 제공한다.
///
/// 사용법:
///   import 'package:shared_themes/shared_themes.dart';
///
/// 주의: UIColorsExtension (context.uiColors)은 각 앱에서 정의해야 한다.
///       (앱별 dataService에 의존하기 때문)
library shared_themes;

export 'color_themes.dart';
export 'ui_colors.dart';
