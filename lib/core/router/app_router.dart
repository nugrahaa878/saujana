import 'package:go_router/go_router.dart';
import 'package:saujana/core/db/hive_service.dart';
import 'package:saujana/features/assessment/assessment_screen.dart';
import 'package:saujana/features/history/history_screen.dart';
import 'package:saujana/features/home/home_screen.dart';
import 'package:saujana/features/onboarding/onboarding_screen.dart';
import 'package:saujana/features/result/result_screen.dart';
import 'package:saujana/features/settings/settings_screen.dart';

class AppRoutes {
  static const home       = '/';
  static const onboarding = '/onboarding';
  static const assessment = '/assessment';
  static const result     = '/result';
  static const history    = '/history';
  static const settings   = '/settings';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  redirect: (context, state) {
    // First launch: redirect to onboarding before showing home
    if (state.uri.path == AppRoutes.home && !HiveService.hasSeenOnboarding) {
      return AppRoutes.onboarding;
    }
    return null;
  },
  routes: [
    GoRoute(
      path:    AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path:    AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path:    AppRoutes.assessment,
      builder: (context, state) => const AssessmentScreen(),
    ),
    GoRoute(
      path:    AppRoutes.result,
      builder: (context, state) {
        // Expects: {'score': int, 'severity': String, 'answers': List<int>}
        final extra = state.extra as Map<String, dynamic>;
        return ResultScreen(
          score:    extra['score'] as int,
          severity: extra['severity'] as String,
          answers:  List<int>.from(extra['answers'] as List),
        );
      },
    ),
    GoRoute(
      path:    AppRoutes.history,
      builder: (context, state) => const HistoryScreen(),
    ),
    GoRoute(
      path:    AppRoutes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
