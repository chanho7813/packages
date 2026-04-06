/// bible_translation.dart
///
/// 역할: 앱이 지원하는 성경 번역본의 메타데이터를 정의한다.

/// BibleTranslation — 단일 번역본 메타데이터
class BibleTranslation {
  final String id;
  final String shortName;
  final String language;
  final String fullName;
  final String assetPath;

  const BibleTranslation({
    required this.id,
    required this.shortName,
    required this.language,
    required this.fullName,
    required this.assetPath,
  });

  String get displayLabel => '$shortName ($language)';
}

/// BibleTranslations — 지원 번역본 목록
class BibleTranslations {
  static const krv = BibleTranslation(
    id: 'krv',
    shortName: 'KRV',
    language: '한국어',
    fullName: '개역한글 (Korean Revised Version)',
    assetPath: 'assets/bible_krv.json',
  );

  static const niv = BibleTranslation(
    id: 'niv',
    shortName: 'NIV',
    language: 'English',
    fullName: 'New International Version',
    assetPath: 'assets/bible_niv.json',
  );

  static const List<BibleTranslation> all = [krv, niv];

  static BibleTranslation? getById(String id) {
    try {
      return all.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }
}
