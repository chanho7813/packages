/// category_chip_filter.dart
///
/// 역할: 카테고리별 필터링을 위한 수평 스크롤 탭 칩 위젯.
///       "전체" 탭과 각 카테고리 탭을 칩 형태로 나열하며, 선택 상태에 따라 색상이 변한다.
///       선택된 탭이 항상 보이도록 자동 스크롤한다.
import 'package:flutter/material.dart';
import 'package:shared_themes/shared_themes.dart';

/// CategoryChipFilter
///
/// 역할: 카테고리 필터 탭 바를 가로 스크롤 칩 목록으로 렌더링한다.
///       selectedIndex가 변경되면 해당 칩이 왼쪽에 보이도록 자동 스크롤한다.
class CategoryChipFilter extends StatefulWidget {
  /// 카테고리 이름 목록
  final List<String> categories;

  /// true이면 "전체" 탭 하나만 표시
  final bool showOnlyAll;

  /// 현재 선택된 탭 인덱스 (0 = 전체)
  final int selectedIndex;

  /// 탭 선택 콜백
  final Function(int) onSelect;

  /// 인덱스별 항목 수 맵
  final Map<int, int> counts;

  /// "전체" 탭 라벨 (기본: '전체')
  final String allLabel;

  const CategoryChipFilter({
    super.key,
    required this.categories,
    required this.showOnlyAll,
    required this.selectedIndex,
    required this.onSelect,
    required this.counts,
    this.allLabel = '전체',
  });

  @override
  State<CategoryChipFilter> createState() => _CategoryChipFilterState();
}

class _CategoryChipFilterState extends State<CategoryChipFilter> {
  final List<GlobalKey> _chipKeys = [];

  @override
  void initState() {
    super.initState();
    _ensureKeys();
  }

  @override
  void didUpdateWidget(covariant CategoryChipFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    _ensureKeys();
    if (oldWidget.selectedIndex != widget.selectedIndex) {
      _scrollToSelected();
    }
  }

  void _ensureKeys() {
    final itemCount = widget.showOnlyAll ? 1 : (widget.categories.length + 1);
    while (_chipKeys.length < itemCount) {
      _chipKeys.add(GlobalKey());
    }
  }

  void _scrollToSelected() {
    final index = widget.selectedIndex;
    if (index < 0 || index >= _chipKeys.length) return;
    final keyContext = _chipKeys[index].currentContext;
    if (keyContext == null) return;
    Scrollable.ensureVisible(
      keyContext,
      alignment: 0.0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final uiColors = context.uiColors;
    final itemCount = widget.showOnlyAll ? 1 : (widget.categories.length + 1);

    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: itemCount,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final isSelected = widget.selectedIndex == index;
          final label = index == 0 ? widget.allLabel : widget.categories[index - 1];
          final count = widget.counts[index] ?? 0;

          return GestureDetector(
            key: _chipKeys[index],
            onTap: () => widget.onSelect(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? uiColors.categoryChipBackgroundSelected
                    : uiColors.categoryChipBackground,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? uiColors.categoryChipBorderSelected
                      : uiColors.categoryChipBorder,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (index == 0) ...[
                    Icon(
                      Icons.all_inclusive_rounded,
                      size: 14,
                      color: isSelected
                          ? uiColors.categoryChipTextSelected
                          : uiColors.chipText,
                    ),
                    const SizedBox(width: 6),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.w400,
                      color: isSelected
                          ? uiColors.categoryChipTextSelected
                          : uiColors.categoryChipTextUnselected,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 1),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? uiColors.categoryChipCountBadgeSelected
                          : uiColors.categoryChipCountBadgeUnselected,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      '$count',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? uiColors.categoryChipCountTextSelected
                            : uiColors.categoryChipCountTextUnselected,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
