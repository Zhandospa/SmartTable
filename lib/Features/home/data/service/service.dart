import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onay/Core/%D1%81onfig.dart';
import 'package:onay/Features/home/data/models/menu_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/shared/utils/auth_povider.dart';

class MenuService {
  final Ref ref;
  final String apiUrl = '${Config.baseUrl}/api/menu';

  MenuService(this.ref);

  Future<List<MenuCategory>> fetchMenu() async {
    final authHeader = getAuthHeaderFromRef(ref);

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json; charset=utf-8",
          "Authorization": authHeader!,
        },
      );

      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        print("Decoded response: $data");
        return data.map((item) => MenuCategory.fromJson(item)).toList();
      } else {
        throw Exception("Ошибка загрузки меню: ${response.statusCode}");
      }
    } catch (e) {
      print("Ошибка запроса: $e");
      throw Exception("Ошибка запроса: $e");
    }
  }
}
