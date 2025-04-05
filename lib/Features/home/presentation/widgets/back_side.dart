import 'package:flutter/material.dart';
import 'package:onay/Features/home/presentation/widgets/card_container.dart';


class BackSide extends StatelessWidget {
  final VoidCallback onCloseTap;
  final String description;

  const BackSide({super.key, required this.onCloseTap, required this.description});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCloseTap,
      child: CardContainer(
        child: Stack(
          children: [
            Center(
              child: Text(description, style: const TextStyle(fontSize: 16, color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}