import 'package:language_learning_app/data/datasources/local/hive_datasource.dart';
import 'package:language_learning_app/domain/entities/user.dart';
import 'package:language_learning_app/domain/repositories/user_repository.dart';
import 'package:language_learning_app/data/models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final HiveDataSource dataSource;

  UserRepositoryImpl(this.dataSource);

  @override
  Future<User?> getCurrentUser() async {
    final userModel = await dataSource.getCurrentUser();
    return userModel?.toDomain();
  }

  @override
  Future<void> saveUser(User user) async {
    final userModel = UserModel.fromDomain(user);
    await dataSource.saveUser(userModel);
  }

  @override
  Future<List<String>> getAchievements() async {
    final achievements = await dataSource.getAchievements();
    return achievements.where((a) => a.isUnlocked).map((a) => a.id).toList();
  }

  @override
  Future<void> unlockAchievement(String achievementId) async {
    await dataSource.unlockAchievement(achievementId);
  }
}
