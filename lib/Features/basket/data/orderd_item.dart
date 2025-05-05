import 'package:onay/Features/home/data/models/dish.dart';

class OrderedItem {
  final Dish dish;
  final int quantity;

  OrderedItem({required this.dish, required this.quantity});

  factory OrderedItem.fromJson(Map<String, dynamic> json) {
    return OrderedItem(
      dish: Dish.fromJson(json['dish']),
      quantity: json['quantity'],
    );
  }
}
