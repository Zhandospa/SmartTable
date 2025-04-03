import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math';
import 'package:onay/Features/home/presentation/widgets/back_side.dart';
import 'package:onay/Features/home/presentation/widgets/front_side.dart';

class FlipCard extends ConsumerStatefulWidget {
  final dynamic dish;

  const FlipCard({super.key, required this.dish});

  @override
  ConsumerState<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends ConsumerState<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  bool get isActive => ref.watch(expandedCardProvider) == widget.dish.id;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant FlipCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (isActive && !_isFlipped) {
      _controller.forward();
      _isFlipped = true;
    } else if (!isActive && _isFlipped) {
      _controller.reverse();
      _isFlipped = false;
    }
  }

  void _flipToBack() {
    ref.read(expandedCardProvider.notifier).state = widget.dish.id;
  }

  void _flipToFront() {
    ref.read(expandedCardProvider.notifier).state = null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) {
        final isBack = _animation.value > pi / 2;
        final rotationY = isBack ? _animation.value - pi : _animation.value;

        return GestureDetector(
          onTap: isBack ? _flipToFront : _flipToBack,
          child: Transform(
            transform: Matrix4.rotationY(rotationY),
            alignment: Alignment.center,
            child: isBack
                ? Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(pi),
                    child: BackSide(
                      description: widget.dish.description,
                      onCloseTap: _flipToFront,
                    ),
                  )
                : FrontSide(
                    dish: widget.dish,
                    onInfoTap: _flipToBack,
                  ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
