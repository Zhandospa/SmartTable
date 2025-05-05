import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onay/Core/%D1%81onfig.dart';

import 'package:onay/Features/home/data/models/dish.dart';
import 'package:onay/shared/utils/auth_povider.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DishService {
  final Ref ref;
  final String apiUrl = '${Config.baseUrl}/api/dishes';

  DishService(this.ref);

  Future<List<Dish>> fetchDishes(int categoryId) async {
    final authHeader = getAuthHeaderFromRef(ref);

    try {
      final response = await http.get(
        Uri.parse('$apiUrl/category/$categoryId'),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": authHeader!,
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        return data.map((item) => Dish.fromJson(item)).toList();
      } else {
        throw Exception("Ошибка загрузки блюд: ${response.statusCode} DishService");
      }
    } catch (e) {
      throw Exception("Ошибка запроса: $e DishService");
    }
  }
}
