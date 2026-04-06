/// bible_reference_parser.dart
///
/// 역할: 자유 텍스트에서 성경 구절 참조를 감지하고 파싱한다.
///       정식 이름(요한복음)과 축약 이름(요) 모두 지원하며,
///       범위(3:5-6), 쉼표(4:6,7), 상/하 표기를 처리한다.
import 'bible_book_names.dart';

/// BibleReference — 감지된 성경 참조 하나를 나타내는 데이터 클래스
class BibleReference {
  final String bookName;
  final int chapter;
  final List<int> verses;
  final String? portion;
  final String originalText;

  const BibleReference({
    required this.bookName,
    required this.chapter,
    required this.verses,
    this.portion,
    required this.originalText,
  });

  /// 참조 표시 문자열 (예: '요한복음 3:16')
  String get displayReference {
    if (verses.isEmpty) return '$bookName $chapter';
    if (verses.length == 1) return '$bookName $chapter:${verses.first}';

    bool isConsecutive = true;
    for (int i = 1; i < verses.length; i++) {
      if (verses[i] != verses[i - 1] + 1) {
        isConsecutive = false;
        break;
      }
    }

    if (isConsecutive) {
      return '$bookName $chapter:${verses.first}-${verses.last}';
    }
    return '$bookName $chapter:${verses.join(',')}';
  }
}

/// BibleReferenceParser — 자유 텍스트에서 성경 참조를 찾아내는 파서
class BibleReferenceParser {
  BibleReferenceParser._();

  static RegExp? _cachedRegex;

  static RegExp _getRegex() {
    if (_cachedRegex != null) return _cachedRegex!;

    final allNames = <String>[
      ...BibleBookNames.allBooks,
      ...BibleBookNames.abbreviations.keys,
    ];
    allNames.sort((a, b) => b.length.compareTo(a.length));

    final escaped = allNames.map((n) => RegExp.escape(n)).join('|');

    _cachedRegex = RegExp(
      '($escaped)\\s*(\\d+)\\s*[:장]\\s*(\\d+[상하]?(?:\\s*[-~,]\\s*\\d+[상하]?)*)',
    );
    return _cachedRegex!;
  }

  /// findAll — 텍스트에서 모든 성경 참조를 찾아 반환
  static List<BibleReference> findAll(String text) {
    if (text.isEmpty) return [];

    final regex = _getRegex();
    final matches = regex.allMatches(text);
    final results = <BibleReference>[];

    for (final match in matches) {
      final rawBook = match.group(1)!;
      final chapter = int.parse(match.group(2)!);
      final verseStr = match.group(3)!;

      final bookName = BibleBookNames.resolve(rawBook);
      if (bookName == null) continue;

      String? portion;
      final portionMatch = RegExp(r'([상하])$').firstMatch(verseStr);
      if (portionMatch != null) {
        portion = portionMatch.group(1);
      }

      final verses = <int>[];
      for (final part in verseStr.split(',')) {
        final rangeParts = part.split(RegExp(r'[-~]'));
        if (rangeParts.length == 2) {
          final start = _extractInt(rangeParts[0]);
          final end = _extractInt(rangeParts[1]);
          if (start != null && end != null) {
            for (var i = start; i <= end; i++) {
              verses.add(i);
            }
          }
        } else {
          final v = _extractInt(part);
          if (v != null) verses.add(v);
        }
      }

      if (verses.isEmpty) continue;

      results.add(BibleReference(
        bookName: bookName,
        chapter: chapter,
        verses: verses,
        portion: portion,
        originalText: match.group(0)!,
      ));
    }

    return results;
  }

  static int? _extractInt(String s) =>
      int.tryParse(s.trim().replaceAll(RegExp(r'[^0-9]'), ''));
}
