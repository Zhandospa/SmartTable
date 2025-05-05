import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:onay/Features/home/data/repository/dish_repository.dart';
import 'package:onay/Features/home/data/service/dish_service.dart';
import 'package:onay/Features/home/data/models/dish.dart';
import 'package:onay/Features/home/data/models/menu_category.dart';
import 'package:onay/Features/home/data/repository/repository.dart';
import 'package:onay/Features/home/data/service/service.dart';
import 'package:onay/shared/utils/session_provider.dart';

final menuServiceProvider = Provider<MenuService>((ref) => MenuService(ref));

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepository(ref.watch(menuServiceProvider));
});

final menuProvider = FutureProvider<List<MenuCategory>>((ref) async {
  final sessionId = ref.watch(sessionProvider);
  if (sessionId == null) {
    throw Exception("Нет сессии — авторизуйся сначала");
  }
  ref.keepAlive();
  final menu = await ref.watch(menuRepositoryProvider).getMenu();
  menu.sort((a, b) => a.id.compareTo(b.id)); // Сортировка по id
  return menu;
});

final dishServiceProvider = Provider<DishService>((ref) => DishService(ref));

final dishRepositoryProvider = Provider<DishRepository>((ref) {
  return DishRepository(ref.watch(dishServiceProvider));
});

final dishProvider = FutureProvider.family<List<Dish>, int>((ref, categoryId) async {
  ref.keepAlive();
  final dishes = await ref.watch(dishRepositoryProvider).getDishes(categoryId);
  dishes.sort((a, b) => a.id.compareTo(b.id)); // Сортировка по id
  return dishes;
});

final expandedCardProvider = StateProvider<int?>((ref) => null);
