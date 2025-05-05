import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:onay/Core/сonfig.dart';
import 'package:onay/Features/home/data/models/dish.dart';
import 'package:onay/shared/utils/auth_povider.dart';

final confirmedOrderServiceProvider = Provider((ref) => ConfirmedOrderService(ref));

class ConfirmedOrder {
  final int id;
  final String sessionId;
  final List<ConfirmedOrderItem> items;

  ConfirmedOrder({
    required this.id,
    required this.sessionId,
    required this.items,
  });

  factory ConfirmedOrder.fromJson(Map<String, dynamic> json) {
    final rawItems = json['items'] as List?;
    return ConfirmedOrder(
      id: json['id'],
      sessionId: json['sessionId'],
      items: rawItems == null
          ? []
          : rawItems
              .where((e) => e != null)
              .map((e) => ConfirmedOrderItem.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }
}

class ConfirmedOrderItem {
  final int id;
  final Dish dish;
  final int quantity;

  ConfirmedOrderItem({
    required this.id,
    required this.dish,
    required this.quantity,
  });

  factory ConfirmedOrderItem.fromJson(Map<String, dynamic> json) {
    return ConfirmedOrderItem(
      id: json['id'],
      dish: Dish.fromJson(json['dish']),
      quantity: json['quantity'],
    );
  }
}

class ConfirmedOrderService {
  final Ref ref;
  ConfirmedOrderService(this.ref);

  /// Получение подтвержденных заказов по sessionId
  Future<List<ConfirmedOrder>> getOrders(String sessionId) async {
    final authHeader = getAuthHeaderFromRef(ref);
    final url = Uri.parse('${Config.baseUrl}/api/order/confirmed/$sessionId');

    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": authHeader!,
      },
    );
    print('📦 raw response: ${utf8.decode(response.bodyBytes)}');

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
      return data.map((e) => ConfirmedOrder.fromJson(e)).toList();
    } else {
      throw Exception("Ошибка загрузки заказов: ${response.statusCode}");
    }
  }

  /// Удаление подтвержденных заказов по sessionId (после оплаты)
  Future<void> clearOrders(String sessionId) async {
    final authHeader = getAuthHeaderFromRef(ref);
    final url = Uri.parse('${Config.baseUrl}/api/order/confirmed/$sessionId');

    final response = await http.delete(
      url,
      headers: {
        "Authorization": authHeader!,
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Ошибка удаления заказов: ${response.statusCode}");
    }
  }
}
