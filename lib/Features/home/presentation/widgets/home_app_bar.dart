import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/presentation/providers/basket_provider.dart';
import 'package:onay/shared/app_router.dart';
import 'package:onay/shared/global_key.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String totalPrice;

  const HomeAppBar({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemCount = ref.watch(totalDish);

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Меню", style: TextStyle(fontSize: 18)),
          ElevatedButton(
            key: cartKey,
            onPressed: () => context.router.push(const BasketRoute()),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(0, 122, 255, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.shopping_cart, color: Colors.white, size: 24), // Иконка корзины
                const SizedBox(width: 8), // Отступ
                  Text(
                  '$itemCount', // Количество блюд
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ), 
                const SizedBox(width: 8), // Отступ
                Text( totalPrice == '0'?'         0₸':
                  "$totalPrice ₸",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox()
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
