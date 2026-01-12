import 'package:dartz/dartz.dart';
import 'package:language_learning_app/core/error/failures.dart';
import 'package:language_learning_app/domain/entities/lesson.dart';
import 'package:language_learning_app/domain/repositories/lesson_repository.dart';

class GetLessonsUseCase {
  final LessonRepository repository;

  GetLessonsUseCase(this.repository);

  Future<Either<Failure, List<Lesson>>> call(String category) async {
    try {
      final lessons = await repository.getLessonsByCategory(category);
      return Right(lessons);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
