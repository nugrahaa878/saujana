import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  HiveService._();

  static const _boxAssessments = 'assessments';
  static const _boxPrefs       = 'prefs';

  static const _keyOnboarding  = 'hasSeenOnboarding';

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxAssessments);
    await Hive.openBox(_boxPrefs);
  }

  static Box get _assessments => Hive.box(_boxAssessments);
  static Box get _prefs       => Hive.box(_boxPrefs);

  // ── Onboarding ────────────────────────────────────────────────────────
  static bool get hasSeenOnboarding =>
      _prefs.get(_keyOnboarding, defaultValue: false) as bool;

  static Future<void> markOnboardingSeen() =>
      _prefs.put(_keyOnboarding, true);

  // ── Assessments ───────────────────────────────────────────────────────
  static Future<void> saveAssessment({
    required List<int> answers,
    required int score,
    required String severity,
  }) async {
    final key = DateTime.now().millisecondsSinceEpoch.toString();
    await _assessments.put(key, {
      'id':        key,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'answers':   answers,
      'score':     score,
      'severity':  severity,
    });
  }

  // Returns newest first
  static List<Map<String, dynamic>> getAllAssessments() {
    final results = _assessments.values
        .map((e) => Map<String, dynamic>.from(e as Map))
        .toList();
    results.sort(
      (a, b) => (b['timestamp'] as int).compareTo(a['timestamp'] as int),
    );
    return results;
  }

  static Map<String, dynamic>? getLatestAssessment() {
    final all = getAllAssessments();
    return all.isEmpty ? null : all.first;
  }

  static Future<void> deleteAssessment(String id) =>
      _assessments.delete(id);

  static Future<void> deleteAllData() async {
    await _assessments.clear();
    await _prefs.clear();
  }

  // ── Scoring helpers ───────────────────────────────────────────────────
  static int computeScore(List<int> answers) =>
      answers.fold(0, (sum, a) => sum + a);

  static String computeSeverity(int score) {
    if (score <= 4)  return 'minimal';
    if (score <= 9)  return 'mild';
    if (score <= 14) return 'moderate';
    return 'severe';
  }
}
