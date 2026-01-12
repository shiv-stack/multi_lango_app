import 'package:hive/hive.dart';
import 'package:language_learning_app/domain/entities/progress.dart';

part 'progress_model.g.dart';

@HiveType(typeId: 1)
class ProgressModel extends HiveObject implements Progress {
  @HiveField(0)
  @override
  final String category;

  @HiveField(1)
  @override
  final double percentage;

  @HiveField(2)
  @override
  final int lessonsCompleted;

  @HiveField(3)
  @override
  final int totalLessons;

  ProgressModel({
    required this.category,
    required this.percentage,
    required this.lessonsCompleted,
    required this.totalLessons,
  });

  factory ProgressModel.fromDomain(Progress progress) => ProgressModel(
    category: progress.category,
    percentage: progress.percentage,
    lessonsCompleted: progress.lessonsCompleted,
    totalLessons: progress.totalLessons,
  );

  Progress toDomain() => Progress(
    category: category,
    percentage: percentage,
    lessonsCompleted: lessonsCompleted,
    totalLessons: totalLessons,
  );
}
