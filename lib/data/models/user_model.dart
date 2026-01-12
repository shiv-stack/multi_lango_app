import 'package:hive/hive.dart';
import 'package:language_learning_app/domain/entities/user.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject implements User {
  @HiveField(0)
  @override
  final String id;

  @HiveField(1)
  @override
  final String username;

  @HiveField(2)
  @override
  final String email;

  @HiveField(3)
  @override
  final String selectedLanguage;

  @HiveField(4)
  @override
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.selectedLanguage,
    required this.createdAt,
  });

  factory UserModel.fromDomain(User user) => UserModel(
    id: user.id,
    username: user.username,
    email: user.email,
    selectedLanguage: user.selectedLanguage,
    createdAt: user.createdAt,
  );

  User toDomain() => User(
    id: id,
    username: username,
    email: email,
    selectedLanguage: selectedLanguage,
    createdAt: createdAt,
  );
}
