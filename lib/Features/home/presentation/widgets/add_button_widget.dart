import 'package:flutter/material.dart';

class AddButtonWidget extends StatelessWidget {
  final VoidCallback onAddToCart;

  const AddButtonWidget({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAddToCart,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromRGBO(0, 122, 255, 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        "Добавить в корзину",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
