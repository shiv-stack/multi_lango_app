import 'package:hive/hive.dart';

import 'package:language_learning_app/data/datasources/local/hive_datasource.dart';
import 'package:language_learning_app/domain/entities/lesson.dart';
import 'package:language_learning_app/domain/repositories/lesson_repository.dart';
import 'package:language_learning_app/data/models/lesson_model.dart';

class LessonRepositoryImpl implements LessonRepository {
  final HiveDataSource dataSource;

  LessonRepositoryImpl(this.dataSource);

  @override
  Future<List<Lesson>> getLessonsByCategory(String category) async {
    final lessons = await dataSource.getLessonsByCategory(category);
    
    // Initialize lessons if empty
    if (lessons.isEmpty) {
      final sampleLessons = _generateSampleLessons(category);
      await _saveLessons(sampleLessons);
      return sampleLessons.map((e) => e.toDomain()).toList();
    }
    
    return lessons.map((e) => e.toDomain()).toList();
  }

  List<LessonModel> _generateSampleLessons(String category) {
    const titles = {
      'Reading': ['Basic Phrases', 'Numbers 1-20', 'Greetings', 'Colors'],
      'Listening': ['Basic Phrases Audio', 'Numbers Audio', 'Greetings Audio', 'Colors Audio'],
      'Speaking': ['Practice Phrases', 'Numbers Speaking', 'Greetings Practice', 'Colors Speaking'],
      'Grammar': ['Present Tense', 'Articles', 'Prepositions', 'Adjectives'],
    };

    return List.generate(4, (index) => LessonModel(
      id: '${category}_lesson_${index + 1}',
      title: titles[category]![index],
      category: category,
      level: index + 1,
      isCompleted: false,
    ));
  }

  Future<void> _saveLessons(List<LessonModel> lessons) async {
    final box = await Hive.openBox<LessonModel>('lessons_box');
    for (final lesson in lessons) {
      await box.put(lesson.id, lesson);
    }
  }
}
