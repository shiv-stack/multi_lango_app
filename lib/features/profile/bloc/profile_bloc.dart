import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning_app/domain/entities/achievement.dart';
import 'package:language_learning_app/domain/entities/user.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileEvent>(_onLoadProfile);
  }

  Future<void> _onLoadProfile(LoadProfileEvent event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    
    // Mock profile data
    await Future.delayed(const Duration(milliseconds: 500));
    
    emit(ProfileLoaded(
      User(id: '1', username: 'DevUser', email: 'dev@example.com', selectedLanguage: 'French', createdAt: DateTime.now()),
      [
        Achievement(id: '1', name: 'Champion', icon: '🏆', isUnlocked: true),
        Achievement(id: '2', name: 'Medal Holder', icon: '🥈', isUnlocked: true),
        Achievement(id: '3', name: 'Successful', icon: '⭐', isUnlocked: false),
      ],
    ));
  }
}
