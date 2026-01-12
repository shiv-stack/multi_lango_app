import 'package:hive/hive.dart';
import 'package:language_learning_app/domain/entities/friend.dart';

part 'friend_model.g.dart';

@HiveType(typeId: 4)
class FriendModel extends HiveObject implements Friend {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String name;

  @HiveField(2)
  @override
  final String avatar;

  @HiveField(3)
  @override
  final double progress;

  FriendModel({
    required this.id,
    required this.name,
    required this.avatar,
    required this.progress,
  });

  factory FriendModel.fromDomain(Friend friend) => FriendModel(
    id: friend.id,
    name: friend.name,
    avatar: friend.avatar,
    progress: friend.progress,
  );

  Friend toDomain() => Friend(
    id: id,
    name: name,
    avatar: avatar,
    progress: progress,
  );
}
