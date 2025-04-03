import 'package:flutter/material.dart';

class CounterWidget extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CounterWidget({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF007AFF), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildCounterButton('-', onDecrement),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "$quantity",
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          _buildCounterButton('+', onIncrement),
        ],
      ),
    );
  }

  Widget _buildCounterButton(String symbol, VoidCallback onPressed) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: const Size(36, 36),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(
        symbol,
        style: const TextStyle(color: Color(0xFF007AFF), fontSize: 16),
      ),
    );
  }
}
