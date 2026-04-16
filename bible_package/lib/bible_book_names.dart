/// bible_book_names.dart
///
/// 역할: 한국어/영어 성경 책 이름의 축약형을 정식 이름으로 변환하는 매핑 테이블.
class BibleBookNames {
  BibleBookNames._();

  /// 정식 한국어 책 이름 66개 (구약 39 + 신약 27)
  static const List<String> allBooks = [
    '창세기', '출애굽기', '레위기', '민수기', '신명기',
    '여호수아', '사사기', '룻기', '사무엘상', '사무엘하',
    '열왕기상', '열왕기하', '역대상', '역대하', '에스라',
    '느헤미야', '에스더', '욥기', '시편', '잠언',
    '전도서', '아가서', '이사야', '예레미야', '예레미야애가',
    '에스겔', '다니엘', '호세아', '요엘', '아모스',
    '오바댜', '요나', '미가', '나훔', '하박국',
    '스바냐', '학개', '스가랴', '말라기',
    '마태복음', '마가복음', '누가복음', '요한복음', '사도행전',
    '로마서', '고린도전서', '고린도후서', '갈라디아서', '에베소서',
    '빌립보서', '골로새서', '데살로니가전서', '데살로니가후서',
    '디모데전서', '디모데후서', '디도서', '빌레몬서',
    '히브리서', '야고보서', '베드로전서', '베드로후서',
    '요한일서', '요한이서', '요한삼서', '유다서', '요한계시록',
  ];

  /// 축약 한국어 이름 → 정식 한국어 이름
  static const Map<String, String> abbreviations = {
    '창': '창세기', '출': '출애굽기', '레': '레위기',
    '민': '민수기', '신': '신명기', '수': '여호수아',
    '삿': '사사기', '룻': '룻기',
    '삼상': '사무엘상', '삼하': '사무엘하',
    '왕상': '열왕기상', '왕하': '열왕기하',
    '대상': '역대상', '대하': '역대하',
    '스': '에스라', '느': '느헤미야', '에': '에스더',
    '욥': '욥기', '시': '시편', '잠': '잠언',
    '전': '전도서', '아': '아가서',
    '사': '이사야', '렘': '예레미야', '애': '예레미야애가',
    '겔': '에스겔', '단': '다니엘',
    '호': '호세아', '욜': '요엘', '암': '아모스',
    '옵': '오바댜', '욘': '요나', '미': '미가',
    '나': '나훔', '합': '하박국', '습': '스바냐',
    '학': '학개', '슥': '스가랴', '말': '말라기',
    '마': '마태복음', '막': '마가복음', '눅': '누가복음',
    '요': '요한복음', '행': '사도행전', '롬': '로마서',
    '고전': '고린도전서', '고후': '고린도후서',
    '갈': '갈라디아서', '엡': '에베소서', '빌': '빌립보서',
    '골': '골로새서', '살전': '데살로니가전서', '살후': '데살로니가후서',
    '딤전': '디모데전서', '딤후': '디모데후서',
    '딛': '디도서', '몬': '빌레몬서',
    '히': '히브리서', '약': '야고보서',
    '벧전': '베드로전서', '벧후': '베드로후서',
    '요일': '요한일서', '요이': '요한이서', '요삼': '요한삼서',
    '유': '유다서', '계': '요한계시록',
  };

  /// 영어 정식 책 이름 66개
  static const List<String> allBooksEng = [
    'Genesis', 'Exodus', 'Leviticus', 'Numbers', 'Deuteronomy',
    'Joshua', 'Judges', 'Ruth', '1 Samuel', '2 Samuel',
    '1 Kings', '2 Kings', '1 Chronicles', '2 Chronicles', 'Ezra',
    'Nehemiah', 'Esther', 'Job', 'Psalms', 'Proverbs',
    'Ecclesiastes', 'Song of Songs', 'Isaiah', 'Jeremiah', 'Lamentations',
    'Ezekiel', 'Daniel', 'Hosea', 'Joel', 'Amos',
    'Obadiah', 'Jonah', 'Micah', 'Nahum', 'Habakkuk',
    'Zephaniah', 'Haggai', 'Zechariah', 'Malachi',
    'Matthew', 'Mark', 'Luke', 'John', 'Acts',
    'Romans', '1 Corinthians', '2 Corinthians', 'Galatians', 'Ephesians',
    'Philippians', 'Colossians', '1 Thessalonians', '2 Thessalonians',
    '1 Timothy', '2 Timothy', 'Titus', 'Philemon',
    'Hebrews', 'James', '1 Peter', '2 Peter',
    '1 John', '2 John', '3 John', 'Jude', 'Revelation',
  ];

  /// 영어 약어 → 영어 정식 이름
  static const Map<String, String> abbreviationsEng = {
    'Gen': 'Genesis', 'Ex': 'Exodus', 'Exod': 'Exodus',
    'Lev': 'Leviticus', 'Num': 'Numbers', 'Deut': 'Deuteronomy',
    'Josh': 'Joshua', 'Judg': 'Judges', 'Ru': 'Ruth',
    '1 Sam': '1 Samuel', '2 Sam': '2 Samuel', '1Sam': '1 Samuel', '2Sam': '2 Samuel',
    '1 Kgs': '1 Kings', '2 Kgs': '2 Kings', '1Kgs': '1 Kings', '2Kgs': '2 Kings',
    '1 Chr': '1 Chronicles', '2 Chr': '2 Chronicles', '1Chr': '1 Chronicles', '2Chr': '2 Chronicles',
    'Neh': 'Nehemiah', 'Est': 'Esther',
    'Ps': 'Psalms', 'Psa': 'Psalms', 'Prov': 'Proverbs',
    'Eccl': 'Ecclesiastes', 'Song': 'Song of Songs', 'Isa': 'Isaiah',
    'Jer': 'Jeremiah', 'Lam': 'Lamentations', 'Ezek': 'Ezekiel',
    'Dan': 'Daniel', 'Hos': 'Hosea', 'Ob': 'Obadiah', 'Obad': 'Obadiah',
    'Jon': 'Jonah', 'Mic': 'Micah', 'Nah': 'Nahum',
    'Hab': 'Habakkuk', 'Zeph': 'Zephaniah', 'Hag': 'Haggai',
    'Zech': 'Zechariah', 'Mal': 'Malachi',
    'Matt': 'Matthew', 'Mt': 'Matthew', 'Mk': 'Mark',
    'Lk': 'Luke', 'Jn': 'John', 'Joh': 'John',
    'Rom': 'Romans',
    '1 Cor': '1 Corinthians', '2 Cor': '2 Corinthians', '1Cor': '1 Corinthians', '2Cor': '2 Corinthians',
    'Gal': 'Galatians', 'Eph': 'Ephesians', 'Phil': 'Philippians',
    'Col': 'Colossians',
    '1 Thess': '1 Thessalonians', '2 Thess': '2 Thessalonians', '1Thess': '1 Thessalonians', '2Thess': '2 Thessalonians',
    '1 Tim': '1 Timothy', '2 Tim': '2 Timothy', '1Tim': '1 Timothy', '2Tim': '2 Timothy',
    'Tit': 'Titus', 'Phm': 'Philemon', 'Phlm': 'Philemon',
    'Heb': 'Hebrews', 'Jas': 'James',
    '1 Pet': '1 Peter', '2 Pet': '2 Peter', '1Pet': '1 Peter', '2Pet': '2 Peter',
    '1 Jn': '1 John', '2 Jn': '2 John', '3 Jn': '3 John', '1Jn': '1 John', '2Jn': '2 John', '3Jn': '3 John',
    'Rev': 'Revelation',
  };

  /// 영어 정식 이름 → 한국어 정식 이름
  static const Map<String, String> _engToKor = {
    'Genesis': '창세기', 'Exodus': '출애굽기', 'Leviticus': '레위기',
    'Numbers': '민수기', 'Deuteronomy': '신명기', 'Joshua': '여호수아',
    'Judges': '사사기', 'Ruth': '룻기', '1 Samuel': '사무엘상',
    '2 Samuel': '사무엘하', '1 Kings': '열왕기상', '2 Kings': '열왕기하',
    '1 Chronicles': '역대상', '2 Chronicles': '역대하', 'Ezra': '에스라',
    'Nehemiah': '느헤미야', 'Esther': '에스더', 'Job': '욥기',
    'Psalms': '시편', 'Proverbs': '잠언', 'Ecclesiastes': '전도서',
    'Song of Songs': '아가서', 'Isaiah': '이사야', 'Jeremiah': '예레미야',
    'Lamentations': '예레미야애가', 'Ezekiel': '에스겔', 'Daniel': '다니엘',
    'Hosea': '호세아', 'Joel': '요엘', 'Amos': '아모스',
    'Obadiah': '오바댜', 'Jonah': '요나', 'Micah': '미가',
    'Nahum': '나훔', 'Habakkuk': '하박국', 'Zephaniah': '스바냐',
    'Haggai': '학개', 'Zechariah': '스가랴', 'Malachi': '말라기',
    'Matthew': '마태복음', 'Mark': '마가복음', 'Luke': '누가복음',
    'John': '요한복음', 'Acts': '사도행전', 'Romans': '로마서',
    '1 Corinthians': '고린도전서', '2 Corinthians': '고린도후서',
    'Galatians': '갈라디아서', 'Ephesians': '에베소서', 'Philippians': '빌립보서',
    'Colossians': '골로새서', '1 Thessalonians': '데살로니가전서',
    '2 Thessalonians': '데살로니가후서', '1 Timothy': '디모데전서',
    '2 Timothy': '디모데후서', 'Titus': '디도서', 'Philemon': '빌레몬서',
    'Hebrews': '히브리서', 'James': '야고보서', '1 Peter': '베드로전서',
    '2 Peter': '베드로후서', '1 John': '요한일서', '2 John': '요한이서',
    '3 John': '요한삼서', 'Jude': '유다서', 'Revelation': '요한계시록',
  };

  /// resolve — 축약형이면 정식 이름으로 변환 (한국어만)
  static String? resolve(String name) {
    if (allBooks.contains(name)) return name;
    return abbreviations[name];
  }

  /// resolveEng — 영어 이름/약어를 한국어 정식 이름으로 변환
  /// 반환값: 한국어 정식 이름 (찾지 못하면 null)
  static String? resolveEng(String name) {
    // 정식 영어 이름인 경우
    if (_engToKor.containsKey(name)) return _engToKor[name];
    // 약어인 경우 → 정식 영어 → 한국어
    final fullEng = abbreviationsEng[name];
    if (fullEng != null) return _engToKor[fullEng];
    return null;
  }
}
