import 'package:language_learning_app/domain/entities/user.dart';

abstract class UserRepository {
  Future<User?> getCurrentUser();
  Future<void> saveUser(User user);
  Future<List<String>> getAchievements();
  Future<void> unlockAchievement(String achievementId);
}
