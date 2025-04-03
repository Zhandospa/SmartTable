import 'package:flutter/material.dart';
import 'package:onay/Features/home/presentation/widgets/counter_widget.dart';
import 'package:onay/Features/home/presentation/widgets/add_button_widget.dart';
import 'package:onay/Features/home/presentation/widgets/icon_button_widget.dart';
import 'package:onay/Features/home/presentation/widgets/card_container.dart';

class AnimatedCard extends StatefulWidget {
  final dynamic dish;
  final bool isExpanded;
  final VoidCallback onInfoTap;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onAddToCart;

  const AnimatedCard({
    super.key,
    required this.dish,
    required this.isExpanded,
    required this.onInfoTap,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    required this.onAddToCart,
  });

  @override
  State<AnimatedCard> createState() => _AnimatedCardState();
}

class _AnimatedCardState extends State<AnimatedCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void didUpdateWidget(covariant AnimatedCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isExpanded) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: double.infinity,
                      constraints: BoxConstraints(minHeight: widget.isExpanded ? 135 : 135),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: const DecorationImage(
                          image: AssetImage('images/dish.png'), // Локальный файл в папке assets
                          fit: BoxFit.cover, // Подгоняет изображение
                        ),
                      ),
                    ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButtonWidget(
                    icon: Icons.info_outline,
                    onTap: widget.onInfoTap,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                widget.dish.name,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "${widget.dish.price.toStringAsFixed(0)} ₸",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            SizeTransition(
              sizeFactor: _animation,
              axisAlignment: -1.0,
              child: Column(
                children: [
                  IntrinsicHeight(
                    child: Row(
                      children: [
                        CounterWidget(
                          quantity: widget.quantity,
                          onIncrement: widget.onIncrement,
                          onDecrement: widget.onDecrement,
                        ),
                        Expanded(
                          child: AddButtonWidget(onAddToCart: widget.onAddToCart,),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
