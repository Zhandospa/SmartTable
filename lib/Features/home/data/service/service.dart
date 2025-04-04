import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onay/Features/home/data/models/menu_category.dart';

class MenuService {
  final String apiUrl = 'http://192.168.58.233:8080/api/menu';

  Future<List<MenuCategory>> fetchMenu() async {
    try {
      final response = await http.get(Uri.parse(apiUrl), 
          headers: {"Content-Type": "application/json; charset=utf-8"});

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes)); // исправляем кодировку
        return data.map((item) => MenuCategory.fromJson(item)).toList();
      } else {
        throw Exception("Ошибка загрузки меню: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Ошибка запроса: $e");
    }
  }
}
