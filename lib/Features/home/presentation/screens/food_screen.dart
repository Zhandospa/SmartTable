import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/presentation/providers/home_provider.dart';
import 'package:onay/Features/home/presentation/widgets/flip_card.dart';

final expandedCardProvider = StateProvider<int?>((ref) => null);
@RoutePage()
class FoodScreen extends ConsumerWidget {
  final int categoryId;
  final String categoryTitle;

  const FoodScreen({super.key, required this.categoryId, required this.categoryTitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dishesAsync = ref.watch(dishProvider(categoryId));

    return Scaffold(
      backgroundColor: Colors.white,
      body: dishesAsync.when(
        data: (dishes) => Padding(
          padding: const EdgeInsets.all(10),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:3,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemCount: dishes.length,
            itemBuilder: (context, index) => FlipCard(
              dish: dishes[index],
              onCardTap: () {
                ref.read(expandedCardProvider.notifier).state = dishes[index].id;
              },
            ),
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text("Ошибка загрузки: $error")),
      ),
    );
  }
}
