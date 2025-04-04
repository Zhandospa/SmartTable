import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onay/Features/home/data/models/dish.dart';

class DishService {
  final String apiUrl = 'http://192.168.58.233:8080/api/dishes/';

  Future<List<Dish>> fetchDishes(int categoryId) async {
    try {
      final response = await http.get(
        Uri.parse('$apiUrl$categoryId'),
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return data.map((item) => Dish.fromJson(item)).toList();
      } else {
        throw Exception("Ошибка загрузки блюд: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Ошибка запроса: $e");
    }
  }
}
