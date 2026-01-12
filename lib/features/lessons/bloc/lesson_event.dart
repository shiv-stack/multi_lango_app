import 'package:equatable/equatable.dart';

abstract class LessonEvent extends Equatable {
  const LessonEvent();

  @override
  List<Object?> get props => [];
}

class LoadLessonsEvent extends LessonEvent {
  final String category;

  const LoadLessonsEvent(this.category);

  @override
  List<Object?> get props => [category];
}

class CompleteLessonEvent extends LessonEvent {
  final String category;
  final String lessonId;

  const CompleteLessonEvent(this.category, this. lessonId);

  @override
  List<Object?> get props => [category, lessonId];
}
