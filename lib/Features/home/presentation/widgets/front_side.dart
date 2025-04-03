import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/presentation/providers/basket_provider.dart';
import 'package:onay/Features/home/presentation/widgets/animated_card.dart';

final expandedCardProvider = StateProvider<int?>((ref) => null);

class FrontSide extends ConsumerStatefulWidget {
  final dynamic dish;
  final VoidCallback onInfoTap;

  const FrontSide({
    super.key,
    required this.dish,
    required this.onInfoTap,
  });

  @override
  ConsumerState<FrontSide> createState() => _FrontSideState();
}

class _FrontSideState extends ConsumerState<FrontSide> {
  int quantity = 1;

  void _toggleButtons() {
    final currentExpanded = ref.read(expandedCardProvider);
    if (currentExpanded == widget.dish.id) {
      ref.read(expandedCardProvider.notifier).state = null;
    } else {
      ref.read(expandedCardProvider.notifier).state = widget.dish.id;
    }
  }

  void _increment() {
    setState(() {
      quantity++;
    });
  }

  void _decrement() {
    if (quantity > 1) {
      setState(() {
        quantity--;
      });
    } else {
      _toggleButtons();
    }
  }

  void _addToThisDishinBasket() async{
    ref.read(basketProvider.notifier).addDish(widget.dish, quantity);
    _toggleButtons();
    await Future.delayed(const Duration(milliseconds: 30));
    quantity = 1;
  }
  

  @override
  Widget build(BuildContext context) {
    final isExpanded = ref.watch(expandedCardProvider) == widget.dish.id;

    return GestureDetector(
      onTap: _toggleButtons,
      child: AnimatedCard(
        dish: widget.dish,
        isExpanded: isExpanded,
        onInfoTap: widget.onInfoTap,
        quantity: quantity,
        onIncrement: _increment,
        onDecrement: _decrement,
        onAddToCart: _addToThisDishinBasket,
      ),
    );
  }
}

