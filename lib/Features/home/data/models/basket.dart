class Basket {
  final int id;
  final int userId;
  final List<BasketItem> items;

  Basket({required this.id, required this.userId, required this.items});

  // Фабричный метод для создания объекта из JSON
  factory Basket.fromJson(Map<String, dynamic> json) {
    return Basket(
      id: json['id'],
      userId: json['userId'],
      items: (json['items'] as List)
          .map((item) => BasketItem.fromJson(item))
          .toList(),
    );
  }

  // Метод для преобразования в JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class BasketItem {
  final int id;
  final String name;
  final int quantity;
  final double price;

  BasketItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory BasketItem.fromJson(Map<String, dynamic> json) {
    return BasketItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}
