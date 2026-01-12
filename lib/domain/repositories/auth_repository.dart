import 'package:language_learning_app/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
  Future<User?> signup(String username, String email, String password);
  Future<bool> isAuthenticated();
  Future<void> logout();
}
