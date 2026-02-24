class ApiConfig {
  // Измените на ваш URL
  static const String baseUrl = 'https://letovo.vitrich.ru';
  static const String apiUrl = '$baseUrl/api';
  
  // Endpoints
  static const String login = '$apiUrl/login';
  static const String register = '$apiUrl/register';
  static const String logout = '$apiUrl/logout';
  
  static const String lessons = '$apiUrl/lessons';
  static String lessonById(String date) => '$apiUrl/lessons/$date';
  static String submitLesson(String date) => '$apiUrl/lessons/$date/submit';
  
  static const String studentResults = '$apiUrl/student/results';
  static const String feedback = '$apiUrl/feedback';
  
  // Headers
  static Map<String, String> headers(String? token) => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  };
}
