import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:language_learning_app/domain/usecases/auth/login_usecase.dart';
import 'package:language_learning_app/domain/usecases/auth/signup_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.signupUseCase,
  }) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<SignupEvent>(_onSignup);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase(event.email, event.password);
    result.fold(
      (failure) => emit(AuthError('Invalid credentials')),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onSignup(SignupEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await signupUseCase(event.username, event.email, event.password);
    result.fold(
      (failure) => emit(AuthError('User already exists')),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthUnauthenticated());
  }
}
