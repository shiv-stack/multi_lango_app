// Replace your service_locator.dart with this COMPLETE version:
import 'package:get_it/get_it.dart';

import 'package:language_learning_app/data/datasources/local/hive_datasource.dart';
import 'package:language_learning_app/data/datasources/local/hive_datasource_impl.dart';
import 'package:language_learning_app/data/datasources/repositories/auth_repository_impl.dart';
import 'package:language_learning_app/data/datasources/repositories/lesson_repository_impl.dart';
import 'package:language_learning_app/data/datasources/repositories/progress_repository_impl.dart';
import 'package:language_learning_app/data/datasources/repositories/user_repository_impl.dart';

import 'package:language_learning_app/domain/repositories/auth_repository.dart';
import 'package:language_learning_app/domain/repositories/lesson_repository.dart';
import 'package:language_learning_app/domain/repositories/progress_repository.dart';
import 'package:language_learning_app/domain/repositories/user_repository.dart';
import 'package:language_learning_app/domain/usecases/auth/login_usecase.dart';
import 'package:language_learning_app/domain/usecases/auth/signup_usecase.dart';
import 'package:language_learning_app/domain/usecases/lesson/get_lessons_usecase.dart';
import 'package:language_learning_app/domain/usecases/progress/complete_lesson_usecase.dart';
import 'package:language_learning_app/domain/usecases/progress/get_progress_usecase.dart';
import 'package:language_learning_app/features/auth/bloc/auth_bloc.dart';
import 'package:language_learning_app/features/lessons/bloc/lesson_bloc.dart';
import 'package:language_learning_app/features/progress/bloc/progress_bloc.dart';
import 'package:language_learning_app/features/profile/bloc/profile_bloc.dart';
import 'package:language_learning_app/core/routing/app_router.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Data sources
  sl.registerLazySingleton<HiveDataSource>(() => HiveDataSourceImpl());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton<LessonRepository>(() => LessonRepositoryImpl(sl()));
  sl.registerLazySingleton<ProgressRepository>(() => ProgressRepositoryImpl(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => SignupUseCase(sl()));
  sl.registerLazySingleton(() => GetLessonsUseCase(sl()));
  sl.registerLazySingleton(() => GetProgressUseCase(sl()));
  sl.registerLazySingleton(() => CompleteLessonUseCase(sl()));

  // Blocs
  sl.registerFactory(() => AuthBloc(loginUseCase: sl(), signupUseCase: sl()));
  sl.registerFactory(() => LessonBloc(getLessonsUseCase: sl(), completeLessonUseCase: sl()));
  sl.registerFactory(() => ProgressBloc(getProgressUseCase: sl()));
  sl.registerFactory(() => ProfileBloc());

  // Core
  sl.registerLazySingleton(() => AppRouter());
}
