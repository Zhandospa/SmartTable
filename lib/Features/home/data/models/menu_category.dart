import 'package:onay/Features/home/data/models/Dish.dart';

class MenuCategory {
  final int id; // Если id приходит как int
  final String title;
  final bool isActive;
  final List<Dish> dishes;

  MenuCategory({
    required this.id,
    required this.title,
    this.isActive = true,
    this.dishes = const [],
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'],  // Получаем ID из JSON
      title: json['name'],
      isActive: json['isActive'] ?? true,
      dishes: (json['dishes'] as List?)
              ?.map((dish) => Dish.fromJson(dish))
              .toList() ??
          [], // Обработка null для dishes
    );
  }
}
