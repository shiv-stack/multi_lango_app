import 'package:hive/hive.dart';
import 'package:language_learning_app/domain/entities/achievement.dart';

part 'achievement_model.g.dart';

@HiveType(typeId: 3)
class AchievementModel extends HiveObject implements Achievement {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final String icon;

  @HiveField(3)
  @override
  final bool isUnlocked;

  AchievementModel({
    required this.id,
    required this.name,
    required this.icon,
    this.isUnlocked = false,
  });

  factory AchievementModel.fromDomain(Achievement achievement) => AchievementModel(
    id: achievement.id,
    name: achievement.name,
    icon: achievement.icon,
    isUnlocked: achievement.isUnlocked,
  );

  Achievement toDomain() => Achievement(
    id: id,
    name: name,
    icon: icon,
    isUnlocked: isUnlocked,
  );
}
