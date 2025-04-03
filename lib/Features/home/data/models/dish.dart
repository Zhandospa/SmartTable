class Dish {
  final String name;
  final String description;
  final bool isActive;
  final double price;
  final int id;

  Dish({required this.name, required this.description, required this.price, this.isActive = true, required this.id});

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      isActive: json['isActive'] ?? true,
      id: (json['id'] as num?)?.toInt() ?? 0,
    );
  }

  // Добавляем методы для корректного сравнения
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Dish && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
