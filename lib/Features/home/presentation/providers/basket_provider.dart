import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/data/models/dish.dart';

class BasketNotifier extends StateNotifier<Map<Dish, int>> {
  BasketNotifier() : super({});


  void addDish(Dish dish, int quantity) {
    state = {
      ...state,
      dish: (state[dish] ?? 0) + quantity,
    };
  }

  void removeDish(Dish dish) {
    final newState = Map<Dish, int>.from(state);
    newState.remove(dish);
    state = newState;
  }

  void clearBasket() {
    state = {};
  }
}

final basketProvider = StateNotifierProvider<BasketNotifier, Map<Dish, int>>(
  (ref) => BasketNotifier(),
);

final totalPriceProvider = Provider<double>((ref) {
  return ref.watch(basketProvider).entries.fold(
    0.0,
    (sum, entry) => sum + entry.key.price * entry.value,
  );
});
final totalDish = Provider<int>((ref){
  final length = ref.watch(basketProvider);
  return length.length;
});

