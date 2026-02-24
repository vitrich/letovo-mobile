import 'task.dart';

class Lesson {
  final int id;
  final String date;
  final String title;
  final String? description;
  final List<Task> tasks;
  final bool isCompleted;
  final int totalTasks;
  final int completedTasks;
  
  Lesson({
    required this.id,
    required this.date,
    required this.title,
    this.description,
    required this.tasks,
    this.isCompleted = false,
    this.totalTasks = 0,
    this.completedTasks = 0,
  });
  
  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      date: json['date'],
      title: json['title'],
      description: json['description'],
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((t) => Task.fromJson(t))
          .toList() ?? [],
      isCompleted: json['is_completed'] ?? false,
      totalTasks: json['total_tasks'] ?? 0,
      completedTasks: json['completed_tasks'] ?? 0,
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'date': date,
    'title': title,
    'description': description,
    'tasks': tasks.map((t) => t.toJson()).toList(),
    'is_completed': isCompleted,
    'total_tasks': totalTasks,
    'completed_tasks': completedTasks,
  };
  
  double get progress => 
      totalTasks > 0 ? completedTasks / totalTasks : 0.0;
}
