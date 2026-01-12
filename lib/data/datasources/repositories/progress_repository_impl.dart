import 'package:language_learning_app/core/constants/app_constants.dart';
import 'package:language_learning_app/data/datasources/local/hive_datasource.dart';
import 'package:language_learning_app/domain/entities/progress.dart';
import 'package:language_learning_app/domain/repositories/progress_repository.dart';
import 'package:language_learning_app/data/models/progress_model.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  final HiveDataSource dataSource;

  ProgressRepositoryImpl(this.dataSource);

  @override
  Future<List<Progress>> getProgress() async {
    final progressList = await dataSource.getProgress();
    
    if (progressList.isEmpty) {
      final sampleProgress = _initializeProgress();
      await _saveInitialProgress(sampleProgress);
      return sampleProgress.map((e) => e.toDomain()).toList();
    }
    
    return progressList.map((e) => e.toDomain()).toList();
  }

  @override
  Future<void> completeLesson(String category, String lessonId) async {
    await dataSource.completeLesson(category, lessonId);
  }

  @override
  Future<void> updateProgress(String category, double percentage) async {
    final progress = ProgressModel(
      category: category,
      percentage: percentage,
      lessonsCompleted: (percentage / 100 * 4).round(),
      totalLessons: 4,
    );
    await dataSource.saveProgress(progress);
  }

  List<ProgressModel> _initializeProgress() {
    return AppConstants.categories.map((category) => ProgressModel(
      category: category,
      percentage: 0.0,
      lessonsCompleted: 0,
      totalLessons: 4,
    )).toList();
  }

  Future<void> _saveInitialProgress(List<ProgressModel> progress) async {
    for (final p in progress) {
      await dataSource.saveProgress(p);
    }
  }
}
