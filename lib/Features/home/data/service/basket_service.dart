import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:onay/Features/home/data/models/basket.dart';

class BasketService {
  final String baseUrl = 'http://your-server.com/api/basket'; // Укажи свой URL

  // Получить корзину пользователя
  Future<Basket> getBasket(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/$userId'));

    if (response.statusCode == 200) {
      return Basket.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Ошибка при загрузке корзины');
    }
  }

  // Добавить товар в корзину
  Future<void> addItemToBasket(int userId, BasketItem item) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$userId/items'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(item.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка при добавлении товара');
    }
  }

  // Удалить товар из корзины
  Future<void> removeItemFromBasket(int userId, int itemId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$userId/items/$itemId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка при удалении товара');
    }
  }

  // Очистить корзину
  Future<void> clearBasket(int userId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$userId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Ошибка при очистке корзины');
    }
  }
}
