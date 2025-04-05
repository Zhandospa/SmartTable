import 'package:flutter/material.dart';

class OpacityBanner extends StatefulWidget {
  final String image;

  const OpacityBanner({super.key, required this.image});

  @override
  State<OpacityBanner> createState() => _OpacityBannerState();
}

class _OpacityBannerState extends State<OpacityBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Image.asset(
        widget.image,
        fit: BoxFit.cover,
      ),
    );
  }
}
