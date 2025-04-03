import 'package:onay/Features/home/data/models/Dish.dart';

class MenuCategory {
  final int id; // Добавлен ID
  final String title;
  final String description;
  final bool isActive;
  final List<Dish> dishes;

  MenuCategory({
    required this.id,  // ID теперь обязательный
    required this.title,
    required this.description,
    this.isActive = true,
    this.dishes = const [],
  });

  factory MenuCategory.fromJson(Map<String, dynamic> json) {
    return MenuCategory(
      id: json['id'],  // Получаем ID из JSON
      title: json['title'],
      description: json['description'],
      isActive: json['isActive'] ?? true,
      dishes: (json['dishes'] as List?)?.map((dish) => Dish.fromJson(dish)).toList() ?? [],
    );
  }
}
