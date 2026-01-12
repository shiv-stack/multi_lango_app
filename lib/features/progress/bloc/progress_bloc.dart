import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning_app/domain/usecases/progress/get_progress_usecase.dart';
import 'progress_event.dart';
import 'progress_state.dart';

class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  final GetProgressUseCase getProgressUseCase;

  ProgressBloc({required this.getProgressUseCase}) : super(ProgressInitial()) {
    on<LoadProgressEvent>(_onLoadProgress);
  }

  Future<void> _onLoadProgress(LoadProgressEvent event, Emitter<ProgressState> emit) async {
    emit(ProgressLoading());
    final result = await getProgressUseCase();
    result.fold(
      (failure) => emit(ProgressInitial()),
      (progress) => emit(ProgressLoaded(progress)),
    );
  }
}
