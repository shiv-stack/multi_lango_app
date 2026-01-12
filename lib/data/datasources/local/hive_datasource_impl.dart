import 'package:hive_flutter/hive_flutter.dart';

import 'package:language_learning_app/data/datasources/local/hive_datasource.dart';
import 'package:language_learning_app/data/models/achievement_model.dart';
import 'package:language_learning_app/data/models/friend_model.dart';
import 'package:language_learning_app/data/models/lesson_model.dart';
import 'package:language_learning_app/data/models/progress_model.dart';
import 'package:language_learning_app/data/models/user_model.dart';

class HiveDataSourceImpl implements HiveDataSource {
  static const String _userBox = 'user_box';
  static const String _progressBox = 'progress_box';
  static const String _lessonsBox = 'lessons_box';
  static const String _friendsBox = 'friends_box';
  static const String _achievementsBox = 'achievements_box';

  @override
  Future<UserModel?> getCurrentUser() async {
    var box = Hive.isBoxOpen(_userBox)
        ? Hive.box<UserModel>(_userBox)
        : await Hive.openBox<UserModel>(_userBox);
    return box.get('current_user');
  }

  @override
  Future<void> saveUser(UserModel user) async {
    var box = Hive.isBoxOpen(_userBox)
        ? Hive.box<UserModel>(_userBox)
        : await Hive.openBox<UserModel>(_userBox);
    await box.put('current_user', user);
  }

  @override
  Future<bool> isUserExists() async {
    var box = Hive.isBoxOpen(_userBox)
        ? Hive.box<UserModel>(_userBox)
        : await Hive.openBox<UserModel>(_userBox);
    return box.containsKey('current_user');
  }

  @override
  Future<List<ProgressModel>> getProgress() async {
    var box = Hive.isBoxOpen(_progressBox)
        ? Hive.box<ProgressModel>(_progressBox)
        : await Hive.openBox<ProgressModel>(_progressBox);
    return box.values.cast<ProgressModel>().toList();
  }

  @override
  Future<void> saveProgress(ProgressModel progress) async {
    var box = Hive.isBoxOpen(_progressBox)
        ? Hive.box<ProgressModel>(_progressBox)
        : await Hive.openBox<ProgressModel>(_progressBox);
    await box.put(progress.category, progress);
  }

  @override
  Future<void> completeLesson(String category, String lessonId) async {
    var progressBox = Hive.isBoxOpen(_progressBox)
        ? Hive.box<ProgressModel>(_progressBox)
        : await Hive.openBox<ProgressModel>(_progressBox);

    var lessonsBox = Hive.isBoxOpen(_lessonsBox)
        ? Hive.box<LessonModel>(_lessonsBox)
        : await Hive.openBox<LessonModel>(_lessonsBox);

    // ✅ FIXED: Use proper lesson key format
    final lessonKey = '${category}_$lessonId'; // e.g., "Reading_lesson_1"
    final lesson = lessonsBox.get(lessonKey);

    if (lesson != null) {
      // ✅ FIXED: Create completely new LessonModel instance
      final updatedLesson = LessonModel(
        id: lessonId, // Use lessonId directly
        title: lesson.title,
        category: lesson.category,
        level: lesson.level,
        isCompleted: true,
      );
      await lessonsBox.put(lessonKey, updatedLesson);
    }

    // Update progress
    final progress = progressBox.get(category);
    if (progress != null) {
      final newCompleted = progress.lessonsCompleted + 1;
      final newPercentage = (newCompleted / progress.totalLessons) * 100;
      final updatedProgress = ProgressModel(
        category: category,
        percentage: newPercentage.clamp(0.0, 100.0),
        lessonsCompleted: newCompleted,
        totalLessons: progress.totalLessons,
      );
      await saveProgress(updatedProgress);
    }
  }

  @override
  Future<List<LessonModel>> getLessonsByCategory(String category) async {
    var box = Hive.isBoxOpen(_lessonsBox)
        ? Hive.box<LessonModel>(_lessonsBox)
        : await Hive.openBox<LessonModel>(_lessonsBox);
    return box.values
        .where((lesson) => lesson.category == category)
        .cast<LessonModel>()
        .toList();
  }

  @override
  Future<List<FriendModel>> getFriends() async {
    var box = Hive.isBoxOpen(_friendsBox)
        ? Hive.box<FriendModel>(_friendsBox)
        : await Hive.openBox<FriendModel>(_friendsBox);
    return box.values.cast<FriendModel>().toList();
  }

  @override
  Future<void> addFriend(FriendModel friend) async {
    var box = Hive.isBoxOpen(_friendsBox)
        ? Hive.box<FriendModel>(_friendsBox)
        : await Hive.openBox<FriendModel>(_friendsBox);
    await box.add(friend);
  }

  @override
  Future<List<AchievementModel>> getAchievements() async {
    var box = Hive.isBoxOpen(_achievementsBox)
        ? Hive.box<AchievementModel>(_achievementsBox)
        : await Hive.openBox<AchievementModel>(_achievementsBox);
    return box.values.cast<AchievementModel>().toList();
  }

  @override
  Future<void> unlockAchievement(String achievementId) async {
    var box = Hive.isBoxOpen(_achievementsBox)
        ? Hive.box<AchievementModel>(_achievementsBox)
        : await Hive.openBox<AchievementModel>(_achievementsBox);

    final achievement = box.get(achievementId);
    if (achievement != null) {
      //  Same pattern for achievements
      final updatedAchievement = AchievementModel(
        id: achievement.id,
        name: achievement.name,
        icon: achievement.icon,
        isUnlocked: true,
      );
      await box.put(achievementId, updatedAchievement);
    }
  }
}
