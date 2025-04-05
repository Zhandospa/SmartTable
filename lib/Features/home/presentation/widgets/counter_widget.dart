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
    // Минимальная высота, чтобы всё было видно
    return SizedBox(
      height: 48,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final buttonSize = constraints.maxHeight;

          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF007AFF), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCounterButton('-', onDecrement, Colors.red, buttonSize),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    "$quantity",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                _buildCounterButton('+', onIncrement, Colors.green, buttonSize),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCounterButton(
    String symbol,
    VoidCallback onPressed,
    Color splashColor,
    double size,
  ) {
    return SizedBox(
      width: size,
      height: size,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          splashColor: splashColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          child: Center(
            child: Text(
              symbol,
              style: TextStyle(
                color: splashColor,
                fontSize: size * 0.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
