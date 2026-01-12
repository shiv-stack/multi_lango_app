import 'package:language_learning_app/domain/repositories/progress_repository.dart';

class CompleteLessonUseCase {
  final ProgressRepository repository;

  CompleteLessonUseCase(this.repository);

  Future<void> call(String category, String lessonId) async {
    await repository.completeLesson(category, lessonId);
  }
}
