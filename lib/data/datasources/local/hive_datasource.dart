import 'package:language_learning_app/data/models/achievement_model.dart';
import 'package:language_learning_app/data/models/friend_model.dart';
import 'package:language_learning_app/data/models/lesson_model.dart';
import 'package:language_learning_app/data/models/progress_model.dart';
import 'package:language_learning_app/data/models/user_model.dart';

abstract class HiveDataSource {
  // User
  Future<UserModel?> getCurrentUser();
  Future<void> saveUser(UserModel user);
  Future<bool> isUserExists();

  // Progress
  Future<List<ProgressModel>> getProgress();
  Future<void> saveProgress(ProgressModel progress);
  Future<void> completeLesson(String category, String lessonId);

  // Lessons
  Future<List<LessonModel>> getLessonsByCategory(String category);

  // Friends
  Future<List<FriendModel>> getFriends();
  Future<void> addFriend(FriendModel friend);

  // Achievements
  Future<List<AchievementModel>> getAchievements();
  Future<void> unlockAchievement(String achievementId);
}
