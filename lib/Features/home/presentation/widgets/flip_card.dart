import 'dart:math';

import 'package:flutter/material.dart';
import 'package:onay/Features/home/presentation/widgets/back_side.dart';
import 'package:onay/Features/home/presentation/widgets/front_side.dart';

class FlipCard extends StatefulWidget {
  final dynamic dish;
  final VoidCallback onCardTap;

  const FlipCard({super.key, required this.dish, required this.onCardTap});

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: pi).animate(_controller);
  }

  void _toggleCard() {
    setState(() => _isFlipped = !_isFlipped);
    _isFlipped ? _controller.forward() : _controller.reverse();
  }

  void _startFrontAnimation() {
    widget.onCardTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _startFrontAnimation();
      },
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          final matrix = Matrix4.identity()..rotateY(_animation.value);
          return Transform(
            transform: matrix,
            alignment: Alignment.center,
            child: _animation.value < pi / 2
                ? FrontSide(dish: widget.dish, onInfoTap: _toggleCard)
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(pi),
                    child: BackSide(onCloseTap: _toggleCard, description: widget.dish.description,),
                  ),
          );
        },
      ),
    );
  }
}