/// bible_service.dart
///
/// 역할: KRV(개역한글)·NIV(영어표준) 성경 JSON 데이터를 로드하고,
///       책/장/절 기준으로 구절 텍스트를 조회하는 서비스.
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

/// BibleService
///
/// 역할: 성경 JSON 파일을 메모리에 캐시하고 구절 조회 API를 제공한다.
///       KRV는 앱 시작 시 즉시 로드, NIV는 처음 필요할 때 지연 로드한다.
class BibleService {
  late Map<String, dynamic> _krv;
  Map<String, dynamic>? _niv;
  bool _useNiv = false;

  /// 현재 번역본이 NIV인지 여부
  bool get isNiv => _useNiv;

  /// 한국어 책 이름 → NIV 영어 책 이름 매핑
  static const Map<String, String> _korToEng = {
    '창세기': 'Genesis', '출애굽기': 'Exodus', '레위기': 'Leviticus',
    '민수기': 'Numbers', '신명기': 'Deuteronomy', '여호수아': 'Joshua',
    '사사기': 'Judges', '룻기': 'Ruth', '사무엘상': '1 Samuel',
    '사무엘하': '2 Samuel', '열왕기상': '1 Kings', '열왕기하': '2 Kings',
    '역대상': '1 Chronicles', '역대하': '2 Chronicles', '에스라': 'Ezra',
    '느헤미야': 'Nehemiah', '에스더': 'Esther', '욥기': 'Job',
    '시편': 'Psalms', '잠언': 'Proverbs', '전도서': 'Ecclesiastes',
    '아가서': 'Song of Songs', '이사야': 'Isaiah', '예레미야': 'Jeremiah',
    '예레미야애가': 'Lamentations', '에스겔': 'Ezekiel', '다니엘': 'Daniel',
    '호세아': 'Hosea', '요엘': 'Joel', '아모스': 'Amos',
    '오바댜': 'Obadiah', '요나': 'Jonah', '미가': 'Micah',
    '나훔': 'Nahum', '하박국': 'Habakkuk', '스바냐': 'Zephaniah',
    '학개': 'Haggai', '스가랴': 'Zechariah', '말라기': 'Malachi',
    '마태복음': 'Matthew', '마가복음': 'Mark', '누가복음': 'Luke',
    '요한복음': 'John', '사도행전': 'Acts', '로마서': 'Romans',
    '고린도전서': '1 Corinthians', '고린도후서': '2 Corinthians',
    '갈라디아서': 'Galatians', '에베소서': 'Ephesians', '빌립보서': 'Philippians',
    '골로새서': 'Colossians', '데살로니가전서': '1 Thessalonians',
    '데살로니가후서': '2 Thessalonians', '디모데전서': '1 Timothy',
    '디모데후서': '2 Timothy', '디도서': 'Titus', '빌레몬서': 'Philemon',
    '히브리서': 'Hebrews', '야고보서': 'James', '베드로전서': '1 Peter',
    '베드로후서': '2 Peter', '요한일서': '1 John', '요한이서': '2 John',
    '요한삼서': '3 John', '유다서': 'Jude', '요한계시록': 'Revelation',
  };

  /// init — KRV JSON 로드
  Future<void> init() async {
    final jsonStr = await rootBundle.loadString('assets/bible_krv.json');
    _krv = json.decode(jsonStr) as Map<String, dynamic>;
  }

  Future<void> _loadNiv() async {
    if (_niv == null) {
      final jsonStr = await rootBundle.loadString('assets/bible_niv.json');
      _niv = json.decode(jsonStr) as Map<String, dynamic>;
    }
  }

  /// switchTranslation — 번역본 전환
  Future<void> switchTranslation(bool useNiv) async {
    if (useNiv) await _loadNiv();
    _useNiv = useNiv;
  }

  /// getVerse — 현재 번역본 기준 단일 구절 조회
  String? getVerse(String book, int chapter, int verse) {
    if (_useNiv && _niv != null) {
      final engBook = _korToEng[book] ?? book;
      final chapters = _niv![engBook] as Map<String, dynamic>?;
      final verses = chapters?['$chapter'] as Map<String, dynamic>?;
      final text = verses?['$verse'] as String?;
      if (text != null) return text;
    }
    final chapters = _krv[book] as Map<String, dynamic>?;
    if (chapters == null) return null;
    final verses = chapters['$chapter'] as Map<String, dynamic>?;
    if (verses == null) return null;
    return verses['$verse'] as String?;
  }

  /// translateBookName — 현재 번역본에 맞는 책 이름 반환
  String translateBookName(String korBook) {
    if (_useNiv) return _korToEng[korBook] ?? korBook;
    return korBook;
  }

  /// getVerses — 동일 장 내 여러 절을 합쳐 반환
  String? getVerses(String book, int chapter, List<int> verses) {
    final parts = <String>[];
    for (final v in verses) {
      final text = getVerse(book, chapter, v);
      if (text != null) parts.add(text);
    }
    return parts.isEmpty ? null : parts.join(' ');
  }

  // ── 특정 번역본 직접 조회 (카드 뒷면 등) ──

  bool get isNivLoaded => _niv != null;

  Future<void> ensureNivLoaded() async => await _loadNiv();

  String? getVerseKrv(String book, int chapter, int verse) {
    final chapters = _krv[book] as Map<String, dynamic>?;
    final verses = chapters?['$chapter'] as Map<String, dynamic>?;
    return verses?['$verse'] as String?;
  }

  String? getVerseNiv(String book, int chapter, int verse) {
    if (_niv == null) return null;
    final engBook = _korToEng[book] ?? book;
    final chapters = _niv![engBook] as Map<String, dynamic>?;
    final verses = chapters?['$chapter'] as Map<String, dynamic>?;
    return verses?['$verse'] as String?;
  }

  String? getVersesKrv(String book, int chapter, List<int> verses) {
    final parts = verses.map((v) => getVerseKrv(book, chapter, v)).whereType<String>().toList();
    return parts.isEmpty ? null : parts.join(' ');
  }

  String? getVersesNiv(String book, int chapter, List<int> verses) {
    final parts = verses.map((v) => getVerseNiv(book, chapter, v)).whereType<String>().toList();
    return parts.isEmpty ? null : parts.join(' ');
  }

  String translateBookNameNiv(String korBook) => _korToEng[korBook] ?? korBook;

  /// 한→영 책 이름 매핑 (UI에서 직접 참조용)
  static Map<String, String> get korToEng => _korToEng;
}
