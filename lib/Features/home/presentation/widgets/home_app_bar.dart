import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/presentation/providers/basket_provider.dart';
import 'package:onay/shared/app_router.dart';
import 'package:onay/shared/global_key.dart';
import 'package:onay/shared/utils/formatters.dart';

class HomeAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String totalPrice;

  const HomeAppBar({super.key, required this.totalPrice});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final itemCount = ref.watch(totalDish);

    return Padding(
      padding: const EdgeInsets.fromLTRB(0,0,0,10),
      child: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Stack(
          alignment: Alignment.center,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Главный",
                style: TextStyle(fontSize: 18),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.1,
                  maxWidth: MediaQuery.of(context).size.width * 0.2,
                ),
                child: ElevatedButton(
                  key: cartKey,
                  onPressed: () => context.router.push(const BasketSwitcherRoute()),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(0, 122, 255, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Icon(Icons.shopping_cart, color: Colors.white, size: 24),
                      const SizedBox(width: 8),
                      Text(
                        '$itemCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        totalPrice == '0'
                            ? '0 ₸'
                            : "${formatPrice(int.tryParse(totalPrice.replaceAll(' ', '')) ?? 0)} ₸",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
