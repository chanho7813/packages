import 'package:flutter/material.dart';

/// 상세 페이지 공통 AppBar
///
/// 양쪽 앱의 상세 화면에서 동일하게 사용하는 AppBar:
/// - 투명 배경, elevation 0
/// - iOS 스타일 뒤로가기 아이콘
/// - 중앙 정렬 제목 (18px, bold)
AppBar detailAppBar({
  required BuildContext context,
  required String title,
  Color? backgroundColor,
  VoidCallback? onBack,
}) {
  final bg = backgroundColor ?? Theme.of(context).scaffoldBackgroundColor;
  final primaryColor = Theme.of(context).colorScheme.primary;

  return AppBar(
    backgroundColor: bg,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      icon: Icon(Icons.arrow_back_ios_new_rounded,
          size: 20, color: primaryColor),
      onPressed: onBack ?? () => Navigator.pop(context),
    ),
    title: Text(
      title,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        letterSpacing: -0.3,
      ),
    ),
    centerTitle: false,
  );
}
