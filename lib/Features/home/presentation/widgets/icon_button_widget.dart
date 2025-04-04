

import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const IconButtonWidget({super.key, required this.onTap, required this.icon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 122, 255, 1),
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
        ),
        padding: const EdgeInsets.all(4),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(3.1416),
          child: Icon(icon, color: Colors.white, size: 18)),
      ),
    );
  }
}
