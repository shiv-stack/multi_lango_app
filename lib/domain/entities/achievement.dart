class Achievement {
  final String id;
  final String name;
  final String icon;
  final bool isUnlocked;

  const Achievement({
    required this.id,
    required this.name,
    required this.icon,
    this.isUnlocked = false,
  });
}
