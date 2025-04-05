import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/presentation/providers/basket_provider.dart';
import 'package:onay/Features/home/presentation/widgets/counter_widget.dart';
import 'package:onay/shared/utils/formatters.dart';
class BasketScreen extends ConsumerWidget {
  const BasketScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final basket = ref.watch(basketProvider);
    final totalPrice = basket.entries.fold(0.0, (sum, entry) => sum + entry.key.price * entry.value);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: basket.length,
            itemBuilder: (context, index) {
              final entry = basket.entries.toList()[index];
              final dish = entry.key;
              final quantity = entry.value;

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 120,
                          width: 120,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/dish.png'),
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
                        Text("${formatPrice(dish.price.toDouble())} ₸"),
                        const SizedBox(width: 20),
                        Row(
                          children: [
                            CounterWidget(
                              quantity: quantity,
                              onIncrement: () {
                                ref.read(basketProvider.notifier).addDish(dish, 1);
                              },
                              onDecrement: () {
                                if (quantity > 1) {
                                  ref.read(basketProvider.notifier).addDish(dish, -1);
                                } else {
                                  ref.read(basketProvider.notifier).removeDish(dish);
                                }
                              },
                            ),
                            const SizedBox(width: 30),
                            Text('${formatPrice((dish.price * quantity).toDouble())}₸',
                                style: const TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 1),
                ],
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
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
