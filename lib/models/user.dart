class User {
  final int id;
  final String name;
  final String email;
  final String role; // 'student' or 'teacher'
  
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
  });
  
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      role: json['role'] ?? 'student',
    );
  }
  
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'email': email,
    'role': role,
  };
  
  bool get isStudent => role == 'student';
  bool get isTeacher => role == 'teacher';
}
