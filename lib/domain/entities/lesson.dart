class Lesson {
  final String id;
  final String title;
  final String category;
  final int level;
  final bool isCompleted;

  const Lesson({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    this.isCompleted = false,
  });
}
