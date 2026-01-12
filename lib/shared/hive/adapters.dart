import 'package:hive/hive.dart';
import 'package:language_learning_app/data/models/achievement_model.dart';
import 'package:language_learning_app/data/models/friend_model.dart';
import 'package:language_learning_app/data/models/lesson_model.dart';
import 'package:language_learning_app/data/models/progress_model.dart';
import 'package:language_learning_app/data/models/user_model.dart';

void registerAdapters() {
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ProgressModelAdapter());
  Hive.registerAdapter(LessonModelAdapter());
  Hive.registerAdapter(AchievementModelAdapter());
  Hive.registerAdapter(FriendModelAdapter());
}
