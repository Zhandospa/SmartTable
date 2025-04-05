import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/presentation/providers/home_provider.dart';
import 'package:onay/Features/home/presentation/widgets/flip_card.dart';

class FoodScreen extends ConsumerStatefulWidget {
  final int categoryId;
  final String categoryTitle;

  const FoodScreen({
    super.key,
    required this.categoryId,
    required this.categoryTitle,
  });

  @override
  ConsumerState<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends ConsumerState<FoodScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context); // обязательно для сохранения состояния

    final dishesAsync = ref.watch(dishProvider(widget.categoryId));

    return dishesAsync.when(
      data: (dishes) => GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
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
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text("Ошибка загрузки: $error")),
    );
  }
}
