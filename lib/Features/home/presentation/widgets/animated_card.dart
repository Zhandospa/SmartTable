import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:onay/Core/%D1%81onfig.dart';
import 'package:onay/Features/home/presentation/widgets/counter_widget.dart';
import 'package:onay/Features/home/presentation/widgets/add_button_widget.dart';
import 'package:onay/Features/home/presentation/widgets/icon_button_widget.dart';
import 'package:onay/Features/home/presentation/widgets/card_container.dart';
import 'package:onay/shared/utils/formatters.dart';

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
    if (widget.dish.isActive) {
      if (widget.isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool available = widget.dish.isActive;
          final double imageHeight = available
              ? (widget.isExpanded
                  ? constraints.maxHeight * 0.56
                  : constraints.maxHeight * 0.7)
              : constraints.maxHeight * 0.7;

          return Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      width: double.infinity,
                      height: imageHeight,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          children: [
                            (widget.dish.imageUrl != null && widget.dish.imageUrl!.trim().isNotEmpty)
                                ? CachedNetworkImage(
                                    imageUrl: '${Config.baseUrl}${widget.dish.imageUrl!}',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Image.asset(
                                      'images/dish${widget.dish.id % 4}.png',
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    ),
                                  )
                                : Image.asset(
                                    'images/dish${widget.dish.id % 4}.png',
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                            if (!available)
                              Container(
                                color: Colors.black.withOpacity(0.5),
                                child: const Center(
                                  child: Text(
                                    "Закончилось",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    if (available)
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
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    widget.dish.name,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 4),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "${formatPrice(widget.dish.price)} ₸",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (available)
                  SizeTransition(
                    sizeFactor: _animation,
                    axisAlignment: -1.0,
                    child: Column(
                      children: [
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: CounterWidget(
                                quantity: widget.quantity,
                                onIncrement: widget.onIncrement,
                                onDecrement: widget.onDecrement,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              flex: 1,
                              child: AddButtonWidget(
                                onAddToCart: widget.onAddToCart,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
