import 'package:flutter/material.dart';

class AddButtonWidget extends StatelessWidget {
  final VoidCallback onAddToCart;

  const AddButtonWidget({super.key, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48, // Теперь по высоте как CounterWidget
      child: ElevatedButton(
        onPressed: onAddToCart,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromRGBO(0, 122, 255, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12), // горизонтальные отступы, по высоте — всё равно
          alignment: Alignment.center, // ⬅️ Центрирует содержимое по вертикали
        ),
        child: const Text(
          "Добавить в корзину",
          textAlign: TextAlign.center, // ⬅️ Центрирует текст по горизонтали
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
