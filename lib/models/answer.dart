class Answer {
  final int taskId;
  final String answer;
  
  Answer({
    required this.taskId,
    required this.answer,
  });
  
  Map<String, dynamic> toJson() => {
    'task_id': taskId,
    'answer': answer,
  };
}
