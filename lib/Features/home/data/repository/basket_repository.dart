
import 'package:onay/Features/home/data/service/basket_service.dart';
import 'package:onay/Features/home/data/models/basket.dart';

class BasketRepository {
  final BasketService _basketService;

  BasketRepository(this._basketService);

  // Получить корзину пользователя
  Future<Basket> getBasket(int userId) async {
    return await _basketService.getBasket(userId);
  }

  // Добавить товар в корзину
  Future<void> addItem(int userId, BasketItem item) async {
    await _basketService.addItemToBasket(userId, item);
  }

  // Удалить товар из корзины
  Future<void> removeItem(int userId, int itemId) async {
    await _basketService.removeItemFromBasket(userId, itemId);
  }

  // Очистить корзину
  Future<void> clearBasket(int userId) async {
    await _basketService.clearBasket(userId);
  }
}
