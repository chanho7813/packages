/// bible_reference_parser.dart
///
/// 역할: 자유 텍스트에서 성경 구절 참조를 감지하고 파싱한다.
///       한국어(요한복음, 요)와 영어(John, Jn) 모두 지원하며,
///       범위(3:5-6), 쉼표(4:6,7), 상/하 표기를 처리한다.
import 'bible_book_names.dart';

/// BibleReference — 감지된 성경 참조 하나를 나타내는 데이터 클래스
class BibleReference {
  final String bookName; // 항상 한국어 정식 이름
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

  static RegExp? _cachedKorRegex;
  static RegExp? _cachedEngRegex;

  static RegExp _getKorRegex() {
    if (_cachedKorRegex != null) return _cachedKorRegex!;

    final allNames = <String>[
      ...BibleBookNames.allBooks,
      ...BibleBookNames.abbreviations.keys,
    ];
    allNames.sort((a, b) => b.length.compareTo(a.length));

    final escaped = allNames.map((n) => RegExp.escape(n)).join('|');

    _cachedKorRegex = RegExp(
      '($escaped)\\s*(\\d+)\\s*[:장]\\s*(\\d+[상하]?(?:\\s*[-~,]\\s*\\d+[상하]?)*)',
    );
    return _cachedKorRegex!;
  }

  static RegExp _getEngRegex() {
    if (_cachedEngRegex != null) return _cachedEngRegex!;

    final allNames = <String>[
      ...BibleBookNames.allBooksEng,
      ...BibleBookNames.abbreviationsEng.keys,
    ];
    allNames.sort((a, b) => b.length.compareTo(a.length));

    final escaped = allNames.map((n) => RegExp.escape(n)).join('|');

    // 영어 참조: "Genesis 1:1", "Gen 1:1", "1 John 3:16" 등
    _cachedEngRegex = RegExp(
      '($escaped)\\s*(\\d+)\\s*:\\s*(\\d+(?:\\s*[-~,]\\s*\\d+)*)',
      caseSensitive: false,
    );
    return _cachedEngRegex!;
  }

  /// findAll — 텍스트에서 모든 성경 참조를 찾아 반환 (한국어 + 영어)
  static List<BibleReference> findAll(String text) {
    if (text.isEmpty) return [];

    final results = <BibleReference>[];

    // 1) 한국어 참조 감지
    final korRegex = _getKorRegex();
    for (final match in korRegex.allMatches(text)) {
      final ref = _parseKorMatch(match);
      if (ref != null) results.add(ref);
    }

    // 2) 영어 참조 감지
    final engRegex = _getEngRegex();
    for (final match in engRegex.allMatches(text)) {
      final ref = _parseEngMatch(match);
      if (ref != null) results.add(ref);
    }

    return results;
  }

  static BibleReference? _parseKorMatch(RegExpMatch match) {
    final rawBook = match.group(1)!;
    final chapter = int.parse(match.group(2)!);
    final verseStr = match.group(3)!;

    final bookName = BibleBookNames.resolve(rawBook);
    if (bookName == null) return null;

    String? portion;
    final portionMatch = RegExp(r'([상하])$').firstMatch(verseStr);
    if (portionMatch != null) {
      portion = portionMatch.group(1);
    }

    final verses = _parseVerses(verseStr);
    if (verses.isEmpty) return null;

    return BibleReference(
      bookName: bookName,
      chapter: chapter,
      verses: verses,
      portion: portion,
      originalText: match.group(0)!,
    );
  }

  static BibleReference? _parseEngMatch(RegExpMatch match) {
    final rawBook = match.group(1)!;
    final chapter = int.parse(match.group(2)!);
    final verseStr = match.group(3)!;

    // 영어 이름/약어 → 한국어 정식 이름으로 변환
    final bookName = _resolveEngToKor(rawBook);
    if (bookName == null) return null;

    final verses = _parseVerses(verseStr);
    if (verses.isEmpty) return null;

    return BibleReference(
      bookName: bookName,
      chapter: chapter,
      verses: verses,
      originalText: match.group(0)!,
    );
  }

  /// 대소문자 무시하고 영어 이름/약어를 한국어 정식 이름으로 변환
  static String? _resolveEngToKor(String name) {
    // 정식 영어 이름 확인
    for (final eng in BibleBookNames.allBooksEng) {
      if (eng.toLowerCase() == name.toLowerCase()) {
        return BibleBookNames.resolveEng(eng);
      }
    }
    // 약어 확인
    for (final abbr in BibleBookNames.abbreviationsEng.keys) {
      if (abbr.toLowerCase() == name.toLowerCase()) {
        return BibleBookNames.resolveEng(abbr);
      }
    }
    return null;
  }

  static List<int> _parseVerses(String verseStr) {
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
    return verses;
  }

  static int? _extractInt(String s) =>
      int.tryParse(s.trim().replaceAll(RegExp(r'[^0-9]'), ''));
}
