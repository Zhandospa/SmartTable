import 'package:flutter/material.dart';

class AnimatedBall extends StatefulWidget {
  final Offset startPosition;
  final Offset endPosition;

  const AnimatedBall({required this.startPosition, required this.endPosition, super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedBallState createState() => _AnimatedBallState();
}

class _AnimatedBallState extends State<AnimatedBall> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 600), vsync: this);
    _animation = Tween<Offset>(begin: widget.startPosition, end: widget.endPosition)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Positioned(
          left: _animation.value.dx,
          top: _animation.value.dy,
          child: Opacity(
            opacity: 1 - _controller.value,
            child: Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
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
