import 'package:equatable/equatable.dart';
import 'package:language_learning_app/domain/entities/lesson.dart';

abstract class LessonState extends Equatable {
  const LessonState();

  @override
  List<Object?> get props => [];
}

class LessonInitial extends LessonState {}

class LessonLoading extends LessonState {}

class LessonsLoaded extends LessonState {
  final List<Lesson> lessons;

  const LessonsLoaded(this.lessons);

  @override
  List<Object?> get props => [lessons];
}

class LessonError extends LessonState {
  final String message;

  const LessonError(this.message);

  @override
  List<Object?> get props => [message];
}
