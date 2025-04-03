import 'package:onay/Features/home/data/service/dish_service.dart';
import 'package:onay/Features/home/data/models/dish.dart';

class DishRepository {
  final DishService dishService;

  DishRepository(this.dishService);

  Future<List<Dish>> getDishes(int categoryId) async {
    return await dishService.fetchDishes(categoryId);
  }
}
