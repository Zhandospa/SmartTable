import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/data/repository/basket_repository.dart';
import 'package:onay/Features/home/data/repository/dish_repository.dart';
import 'package:onay/Features/home/data/service/basket_service.dart';
import 'package:onay/Features/home/data/service/dish_service.dart';
import 'package:onay/Features/home/data/models/dish.dart';
import 'package:onay/Features/home/data/models/menu_category.dart';
import 'package:onay/Features/home/data/repository/repository.dart';
import 'package:onay/Features/home/data/service/service.dart';

final menuServiceProvider = Provider<MenuService>((ref) => MenuService());

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepository(ref.watch(menuServiceProvider));
});

final menuProvider = FutureProvider<List<MenuCategory>>((ref) async {
  return ref.watch(menuRepositoryProvider).getMenu();
});

final dishServiceProvider = Provider<DishService>((ref) => DishService());

final dishRepositoryProvider = Provider<DishRepository>((ref) {
  return DishRepository(ref.watch(dishServiceProvider));
});

final dishProvider = FutureProvider.family<List<Dish>, int>((ref, categoryId) async {
  return await ref.watch(dishRepositoryProvider).getDishes(categoryId);
});
// Провайдер для BasketService
final basketServiceProvider = Provider((ref) => BasketService());

// Провайдер для BasketRepository
final basketRepositoryProvider = Provider((ref) {
  final service = ref.watch(basketServiceProvider);
  return BasketRepository(service);
});





