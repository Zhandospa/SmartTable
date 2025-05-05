import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/data/models/dish.dart';
import 'package:onay/Features/home/presentation/providers/basket_provider.dart';
import 'package:onay/Features/home/presentation/widgets/counter_widget.dart';
import 'package:onay/shared/utils/formatters.dart';
import 'package:onay/Features/order/data/order_service.dart';
import 'package:onay/shared/utils/session_provider.dart';

class BasketScreen extends ConsumerWidget {
  const BasketScreen({super.key});

  Future<void> _submitOrder(
  WidgetRef ref,
  BuildContext context,
  Map<Dish, int> basket,
) async {
  final sessionId = ref.read(sessionProvider);
  final orderService = ref.read(orderServiceProvider);

  if (sessionId == null || basket.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Корзина пуста или не указан стол")),
    );
    return;
  }

  final success = await orderService.sendOrder(sessionId, basket);

  if (success) {
    // ✅ ВАЖНО: подтверждаем заказ
    await orderService.confirmOrder(sessionId);

    ref.read(basketProvider.notifier).clearBasket();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Заказ подтверждён!")),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Ошибка при отправке заказа")),
    );
  }
}


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    final entries = basket.entries.toList();
    final totalPrice = entries.fold(
      0.0,
      (sum, entry) => sum + entry.key.price * entry.value,
    );

    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: entries.length,
                separatorBuilder: (_, __) => const Divider(thickness: 1),
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  final dish = entry.key;
                  final quantity = entry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage('images/dish${index % 4}.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            dish.name,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text("${formatPrice(dish.price)} ₸"),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            CounterWidget(
                              quantity: quantity,
                              onIncrement: () {
                                ref
                                    .read(basketProvider.notifier)
                                    .addDish(dish, 1);
                              },
                              onDecrement: () {
                                if (quantity > 1) {
                                  ref
                                      .read(basketProvider.notifier)
                                      .addDish(dish, -1);
                                } else {
                                  ref
                                      .read(basketProvider.notifier)
                                      .removeDish(dish);
                                }
                              },
                            ),
                            const SizedBox(width: 30),
                            Text(
                              '${formatPrice(dish.price * quantity)}₸',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Сумма: ",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${formatPrice(totalPrice)}₸",
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton.extended(
            backgroundColor: Colors.brown.shade800,
            onPressed: () => _submitOrder(ref, context, basket),
            label: const Text("Подтвердить"),
            icon: const Icon(Icons.check),
          ),
        ),
      ],
    );
  }
}
