import 'package:flutter/material.dart';

class AddButtonWidget extends StatelessWidget {
  final VoidCallback onAddToCart;

  const AddButtonWidget({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onAddToCart,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: const Text(
        "Добавить",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
