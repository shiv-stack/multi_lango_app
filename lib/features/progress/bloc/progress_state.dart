import 'package:equatable/equatable.dart';
import 'package:language_learning_app/domain/entities/progress.dart';

abstract class ProgressState extends Equatable {
  const ProgressState();

  @override
  List<Object?> get props => [];
}

class ProgressInitial extends ProgressState {}

class ProgressLoading extends ProgressState {}

class ProgressLoaded extends ProgressState {
  final List<Progress> progress;

  const ProgressLoaded(this.progress);

  @override
  List<Object?> get props => [progress];
}
