import 'package:hive/hive.dart';
import 'package:language_learning_app/domain/entities/lesson.dart';

part 'lesson_model.g.dart';

@HiveType(typeId: 2)
class LessonModel extends HiveObject implements Lesson {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String title;

  @HiveField(2)
  @override
  final String category;

  @HiveField(3)
  @override
  final int level;

  @HiveField(4)
  @override
  final bool isCompleted;

  LessonModel({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    this.isCompleted = false,
  });

  factory LessonModel.fromDomain(Lesson lesson) => LessonModel(
    id: lesson.id,
    title: lesson.title,
    category: lesson.category,
        level: lesson.level,
    isCompleted: lesson.isCompleted,
  );

  Lesson toDomain() => Lesson(
    id: id,
    title: title,
    category: category,
    level: level,
    isCompleted: isCompleted,
  );
}

