import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../config/api_config.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;
  String? _token;
  final _storage = const FlutterSecureStorage();
  
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _token != null;
  String? get token => _token;
  
  // Инициализация - загрузка токена
  Future<void> init() async {
    _token = await _storage.read(key: 'auth_token');
    if (_token != null) {
      await loadUser();
    }
  }
  
  // Вход
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.login),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
        }),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _token = data['token'];
        _currentUser = User.fromJson(data['user']);
        
        await _storage.write(key: 'auth_token', value: _token);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }
  
  // Регистрация
  Future<bool> register(String name, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.register),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': password,
        }),
      );
      
      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        _token = data['token'];
        _currentUser = User.fromJson(data['user']);
        
        await _storage.write(key: 'auth_token', value: _token);
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Registration error: $e');
      return false;
    }
  }
  
  // Загрузка данных пользователя
  Future<void> loadUser() async {
    if (_token == null) return;
    
    try {
      final response = await http.get(
        Uri.parse('${ApiConfig.apiUrl}/user'),
        headers: ApiConfig.headers(_token),
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _currentUser = User.fromJson(data);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Load user error: $e');
    }
  }
  
  // Выход
  Future<void> logout() async {
    try {
      if (_token != null) {
        await http.post(
          Uri.parse(ApiConfig.logout),
          headers: ApiConfig.headers(_token),
        );
      }
    } catch (e) {
      debugPrint('Logout error: $e');
    } finally {
      _token = null;
      _currentUser = null;
      await _storage.delete(key: 'auth_token');
      notifyListeners();
    }
  }
}
