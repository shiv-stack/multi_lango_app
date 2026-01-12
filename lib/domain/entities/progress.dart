class Progress {
  final String category;
  final double percentage;
  final int lessonsCompleted;
  final int totalLessons;

  const Progress({
    required this.category,
    required this.percentage,
    required this.lessonsCompleted,
    required this.totalLessons,
  });
}
