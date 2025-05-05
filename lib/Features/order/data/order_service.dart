import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:onay/Core/сonfig.dart';
import 'package:onay/Features/home/data/models/dish.dart';
import 'package:onay/shared/utils/auth_povider.dart';

class OrderService {
  final Ref ref;

  OrderService(this.ref);

  /// ⬇️ Отправка временного заказа (в temporary_order)
  Future<bool> sendOrder(String sessionId, Map<Dish, int> basket) async {
    if (basket.isEmpty) return false;

    final items = basket.entries
        .map((entry) => {
              "dishId": entry.key.id,
              "quantity": entry.value,
            })
        .toList();

    final body = jsonEncode({
      "sessionId": sessionId,
      "items": items,
    });

    final authHeader = getAuthHeaderFromRef(ref);

    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/order/temp'), // ⬅️ ИЗМЕНЕНО
      headers: {
        "Content-Type": "application/json",
        "Authorization": authHeader!,
      },
      body: body,
    );

    return response.statusCode == 200;
  }

  /// ✅ Подтверждение заказа
  Future<void> confirmOrder(String sessionId) async {
    final authHeader = getAuthHeaderFromRef(ref);

    final response = await http.post(
      Uri.parse('${Config.baseUrl}/api/order/confirm/$sessionId'),
      headers: {
        "Authorization": authHeader!,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Ошибка при подтверждении заказа");
    }
  }
}

final orderServiceProvider = Provider<OrderService>((ref) {
  return OrderService(ref);
});
