// Replace main.dart completely:
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:language_learning_app/core/di/service_locator.dart';
import 'package:language_learning_app/core/routing/app_router.dart';
import 'package:language_learning_app/core/theme/app_theme.dart';
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
    return MaterialApp.router(
      title: 'Language Learning',
      theme: AppTheme.darkTheme,
      routerConfig: sl<AppRouter>().router,
      debugShowCheckedModeBanner: false,
    );
  }
}
