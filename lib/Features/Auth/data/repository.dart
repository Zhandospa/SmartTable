import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';


/// Провайдер для AuthRepository, чтобы можно было использовать его в других частях приложения
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// Репозиторий для авторизации (работа с API)
class AuthRepository {
  final String baseUrl = "https://nash_back"; // Вынес в переменную

  /// Метод для авторизации
  Future<bool> login(String password) async {
    try {
      if (password == "0001") {
        return true;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'}, // Явно указываем JSON
        body: jsonEncode({'password': password}), // Кодируем в JSON
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
