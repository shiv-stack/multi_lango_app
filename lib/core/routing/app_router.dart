import 'package:go_router/go_router.dart';
import 'package:language_learning_app/features/auth/presentation/onboarding_page.dart';
import 'package:language_learning_app/features/auth/presentation/pages/login_page.dart';
import 'package:language_learning_app/features/auth/presentation/pages/signup_page.dart';
import 'package:language_learning_app/features/dashboard/presentation/pages/home_page.dart';
import 'package:language_learning_app/features/lessons/presentation/pages/lesson_category_page.dart';
import 'package:language_learning_app/features/lessons/presentation/pages/lesson_detail_page.dart';
import 'package:language_learning_app/features/progress/presentation/pages/friends_progress_page.dart';
import 'package:language_learning_app/features/profile/presentation/pages/profile_page.dart';

class AppRouter {
  late final GoRouter router;

  AppRouter() {
    router = GoRouter(
      initialLocation: '/onboarding',
      routes: [
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => const SignupPage(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
          routes: [
            GoRoute(
              path: 'lesson-category/:category',
              builder: (context, state) => LessonCategoryPage(
                category: state.pathParameters['category']!,
              ),
            ),
            GoRoute(
              path: 'lesson/:category/:lessonId',
              builder: (context, state) => LessonDetailPage(
                category: state.pathParameters['category']!,
                lessonId: state.pathParameters['lessonId']!,
              ),
            ),
            GoRoute(
              path: 'friends',
              builder: (context, state) => const FriendsProgressPage(),
            ),
            GoRoute(
              path: 'profile',
              builder: (context, state) => const ProfilePage(),
            ),
          ],
        ),
      ],
    );
  }
}
