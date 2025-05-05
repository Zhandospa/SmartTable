import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:onay/Core/%D1%81onfig.dart';
import 'dart:convert';
import 'dart:convert' show utf8, base64;

/// Провайдер репозитория
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

class AuthRepository {
  final String baseUrl = Config.baseUrl;

  Future<String?> login(String code) async {
    try {
      final basicAuth = 'Basic ' + base64.encode(utf8.encode('$code:placeholder'));

      final response = await http.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode({'code': code}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['role']; // 'TABLE' или 'ADMIN'
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
