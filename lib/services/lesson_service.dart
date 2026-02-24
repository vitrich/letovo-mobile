import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../config/api_config.dart';
import '../models/lesson.dart';
import '../models/answer.dart';

class LessonService {
  final String token;
  
  LessonService(this.token);
  
  // Получить список уроков
  Future<List<Lesson>> getLessons() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.lessons),
        headers: ApiConfig.headers(token),
      );
      
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Lesson.fromJson(json)).toList();
      }
      throw Exception('Failed to load lessons');
    } catch (e) {
      debugPrint('Get lessons error: $e');
      rethrow;
    }
  }
  
  // Получить урок по дате
  Future<Lesson> getLessonByDate(String date) async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.lessonById(date)),
        headers: ApiConfig.headers(token),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Lesson.fromJson(data);
      }
      throw Exception('Failed to load lesson');
    } catch (e) {
      debugPrint('Get lesson error: $e');
      rethrow;
    }
  }
  
  // Отправить ответы на задачи
  Future<Map<String, dynamic>> submitAnswers(
    String lessonDate,
    List<Answer> answers,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.submitLesson(lessonDate)),
        headers: ApiConfig.headers(token),
        body: json.encode({
          'answers': answers.map((a) => a.toJson()).toList(),
        }),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to submit answers');
    } catch (e) {
      debugPrint('Submit answers error: $e');
      rethrow;
    }
  }
  
  // Получить результаты студента
  Future<Map<String, dynamic>> getStudentResults() async {
    try {
      final response = await http.get(
        Uri.parse(ApiConfig.studentResults),
        headers: ApiConfig.headers(token),
      );
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      }
      throw Exception('Failed to load results');
    } catch (e) {
      debugPrint('Get results error: $e');
      rethrow;
    }
  }
}
