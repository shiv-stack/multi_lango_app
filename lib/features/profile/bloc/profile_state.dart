import 'package:equatable/equatable.dart';
import 'package:language_learning_app/domain/entities/achievement.dart';
import 'package:language_learning_app/domain/entities/user.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  final List<Achievement> achievements;

  const ProfileLoaded(this.user, this.achievements);

  @override
  List<Object?> get props => [user, achievements];
}
