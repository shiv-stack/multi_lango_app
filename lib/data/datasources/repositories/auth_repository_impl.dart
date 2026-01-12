import 'package:hive/hive.dart';
import 'package:language_learning_app/data/datasources/local/hive_datasource.dart';
import 'package:language_learning_app/domain/entities/user.dart';
import 'package:language_learning_app/domain/repositories/auth_repository.dart';
import 'package:language_learning_app/data/models/user_model.dart';
import 'package:uuid/uuid.dart';

class AuthRepositoryImpl implements AuthRepository {
  final HiveDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User?> login(String email, String password) async {
    final user = await dataSource.getCurrentUser();
    if (user != null && user.email == email) {
      return user.toDomain();
    }
    return null;
  }

  @override
  Future<User?> signup(String username, String email, String password) async {
    final existingUser = await dataSource.getCurrentUser();
    if (existingUser != null) return null;

    final user = UserModel(
      id: const Uuid().v4(),
      username: username,
      email: email,
      selectedLanguage: 'French',
      createdAt: DateTime.now(),
    );
    
    await dataSource.saveUser(user);
    return user.toDomain();
  }

  @override
  Future<bool> isAuthenticated() async {
    return await dataSource.isUserExists();
  }

  @override
  Future<void> logout() async {
    final box = await Hive.openBox('user_box');
    await box.delete('current_user');
  }
}
