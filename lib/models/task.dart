class Task {
  final int id;
  final int lessonId;
  final String type; // 'fraction_add', 'mixed_add', etc.
  final String question;
  final String? correctAnswer;
  final String? userAnswer;
  final bool? isCorrect;
  final int? attemptCount;
  final DateTime? completedAt;
  
  Task({
    required this.id,
    required this.lessonId,
    required this.type,
    required this.question,
    this.correctAnswer,
    this.userAnswer,
    this.isCorrect,
    this.attemptCount,
    this.completedAt,
  });
  
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'],
      lessonId: json['lesson_id'],
      type: json['type'],
      question: json['question'],
      correctAnswer: json['correct_answer'],
      userAnswer: json['user_answer'],
      isCorrect: json['is_correct'],
      attemptCount: json['attempt_count'],
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'lesson_id': lessonId,
    'type': type,
    'question': question,
    'correct_answer': correctAnswer,
    'user_answer': userAnswer,
    'is_correct': isCorrect,
    'attempt_count': attemptCount,
    'completed_at': completedAt?.toIso8601String(),
  };
  
  bool get isCompleted => userAnswer != null && isCorrect != null;
}
