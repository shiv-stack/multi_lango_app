import 'package:language_learning_app/domain/entities/progress.dart';
abstract class ProgressRepository {
  Future<List<Progress>> getProgress();
  Future<void> completeLesson(String category, String lessonId);
  Future<void> updateProgress(String category, double percentage);
}
