import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/order/data/confirmed_order.dart';
import 'package:onay/shared/utils/session_provider.dart';
import 'package:onay/shared/utils/formatters.dart';

final confirmedOrdersProvider = FutureProvider<List<ConfirmedOrder>>((ref) async {
  final sessionId = ref.watch(sessionProvider);
  if (sessionId == null) throw Exception("Не авторизован");

  return ref.read(confirmedOrderServiceProvider).getOrders(sessionId);
});

class ConfirmedOrdersScreen extends ConsumerWidget {
  const ConfirmedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncOrders = ref.watch(confirmedOrdersProvider);

    return asyncOrders.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, _) => Center(child: Text("Ошибка: $err")),
      data: (orders) {
        // Собираем все блюда из всех заказов
        final allItems = orders.expand((o) => o.items).toList();

        if (allItems.isEmpty) {
          return const Center(child: Text("Нет заказов"));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: allItems.length,
          separatorBuilder: (_, __) => const Divider(),
          itemBuilder: (context, index) {
            final item = allItems[index];
            return ListTile(
              leading: Image.asset(
                'images/dish${item.dish.id % 4}.png',
                width: 50,
              ),
              title: Text(item.dish.name),
              subtitle: Text("Количество: ${item.quantity}"),
              trailing: Text("${formatPrice(item.dish.price * item.quantity)} ₸"),
            );
          },
        );
      },
    );
  }
}
