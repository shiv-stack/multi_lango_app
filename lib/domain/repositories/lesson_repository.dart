import 'package:language_learning_app/domain/entities/lesson.dart';

abstract class LessonRepository {
  Future<List<Lesson>> getLessonsByCategory(String category);
}
