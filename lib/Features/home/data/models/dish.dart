class Dish {
  final String name;
  final String description;
  final bool isActive;
  final double price;
  final int id;
  final String? imageUrl;
  final int? discount; // ← исправлено

  Dish({
    required this.name,
    required this.description,
    required this.price,
    this.isActive = true,
    required this.id,
    required this.imageUrl,
    this.discount, // ← может быть null
  });

  factory Dish.fromJson(Map<String, dynamic> json) {
    return Dish(
      name: json['name'] ?? 'Unknown',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      isActive: json['available'] ?? true,
      id: (json['id'] as num?)?.toInt() ?? 0,
      discount: json['discount'] as int?, // ← исправлено
      imageUrl: json['imageUrl'] as String?,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Dish && id == other.id);

  @override
  int get hashCode => id.hashCode;
}
