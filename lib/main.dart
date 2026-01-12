// Replace main.dart completely:
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:language_learning_app/core/di/service_locator.dart';
import 'package:language_learning_app/core/routing/app_router.dart';
import 'package:language_learning_app/core/theme/app_theme.dart';
import 'package:language_learning_app/features/auth/bloc/auth_bloc.dart';
import 'package:language_learning_app/features/lessons/bloc/lesson_bloc.dart';
import 'package:language_learning_app/features/progress/bloc/progress_bloc.dart';
import 'shared/hive/adapters.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  registerAdapters();
  await setupServiceLocator();

  runApp(const LanguageLearningApp());
}

class LanguageLearningApp extends StatelessWidget {
  const LanguageLearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //  Authentication Bloc (for Login/Signup)
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>(),
        ),

        //  Lesson Management Bloc
        BlocProvider<LessonBloc>(
          create: (context) => sl<LessonBloc>(),
        ),

        //  Progress Tracking Bloc
        BlocProvider<ProgressBloc>(
          create: (context) => sl<ProgressBloc>(),
        ),

        // // ✅ Friends System Bloc
        // BlocProvider<FriendBloc>(
        //   create: (context) => sl<FriendBloc>(),
        // ),

        // // ✅ Achievements Bloc
        // BlocProvider<AchievementBloc>(
        //   create: (context) => sl<AchievementBloc>(),
        // ),
      ],
      child: MaterialApp.router(
        title: 'Language Learning',
        theme: AppTheme.darkTheme,
        routerConfig: sl<AppRouter>().router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
