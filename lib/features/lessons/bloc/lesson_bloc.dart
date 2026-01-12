import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning_app/domain/usecases/lesson/get_lessons_usecase.dart';
import 'package:language_learning_app/domain/usecases/progress/complete_lesson_usecase.dart';
import 'lesson_event.dart';
import 'lesson_state.dart';

class LessonBloc extends Bloc<LessonEvent, LessonState> {
  final GetLessonsUseCase getLessonsUseCase;
  final CompleteLessonUseCase completeLessonUseCase;

  LessonBloc({
    required this.getLessonsUseCase,
    required this.completeLessonUseCase,
  }) : super(LessonInitial()) {
    on<LoadLessonsEvent>(_onLoadLessons);
    on<CompleteLessonEvent>(_onCompleteLesson);
  }

  Future<void> _onLoadLessons(LoadLessonsEvent event, Emitter<LessonState> emit) async {
    emit(LessonLoading());
    final result = await getLessonsUseCase(event.category);
    result.fold(
      (failure) => emit(LessonError('Failed to load lessons')),
      (lessons) => emit(LessonsLoaded(lessons)),
    );
  }

  Future<void> _onCompleteLesson(CompleteLessonEvent event, Emitter<LessonState> emit) async {
    await completeLessonUseCase(event.category, event.lessonId);
    final state = this.state;
    if (state is LessonsLoaded) {
      emit(LessonsLoaded(state.lessons)); // Refresh lessons
    }
  }
}
