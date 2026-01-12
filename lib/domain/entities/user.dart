class User {
  final String id;
  final String username;
  final String email;
  final String selectedLanguage;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.selectedLanguage,
    required this.createdAt,
  });
}
