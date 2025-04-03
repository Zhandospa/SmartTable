import 'package:flutter/material.dart';
import 'package:onay/Features/home/presentation/widgets/card_container.dart';
import 'package:onay/Features/home/presentation/widgets/icon_button_widget.dart';

class BackSide extends StatelessWidget {
  final VoidCallback onCloseTap;
  final String description;

  const BackSide({super.key, required this.onCloseTap, required this.description});


  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Stack(
        children: [
          Center(
            child: Text(description, style: const TextStyle(fontSize: 16, color: Colors.black)),
          ),
          IconButtonWidget(onTap: onCloseTap, icon: Icons.close),
        ],
      ),
    );
  }
}