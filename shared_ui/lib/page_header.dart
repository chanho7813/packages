/// page_header.dart
///
/// 역할: 앱 내 각 탭 페이지 상단에 공통으로 사용되는 헤더 위젯.
///       좌측에 큰 제목과 부제목, 우측에 아이콘 컨테이너를 배치한다.
import 'package:flutter/material.dart';
import 'package:shared_themes/shared_themes.dart';

/// PageHeader
///
/// 역할: 페이지 상단 헤더를 렌더링한다.
class PageHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color? titleColor;
  final double bottomPadding;

  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.titleColor,
    this.bottomPadding = 28,
  });

  @override
  Widget build(BuildContext context) {
    final uiColors = context.uiColors;

    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: bottomPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      fontSize: 26,
                      color: titleColor ?? uiColors.pageTitle,
                      letterSpacing: -0.5,
                    ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: uiColors.iconBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 22, color: uiColors.pageHeaderIconColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: uiColors.pageSubtitle,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
