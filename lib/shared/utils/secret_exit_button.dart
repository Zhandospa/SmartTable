import 'package:flutter/material.dart';
import 'package:onay/shared/utils/pin_code_dialog.dart';

class SecretExitButton extends StatefulWidget {
  const SecretExitButton({super.key});

  @override
  State<SecretExitButton> createState() => _SecretExitButtonState();
}

class _SecretExitButtonState extends State<SecretExitButton> {
  int _tapCounter = 0;
  DateTime? _lastTapTime;

  void _handleTap() {
    final now = DateTime.now();
    if (_lastTapTime == null || now.difference(_lastTapTime!) > const Duration(seconds: 3)) {
      _tapCounter = 0;
    }

    _tapCounter++;
    _lastTapTime = now;

    if (_tapCounter >= 5) {
      _tapCounter = 0;
      _showPinDialog();
    }
  }

  void _showPinDialog() {
    showDialog(
      context: context,
      builder: (context) => const PinCodeDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 50,
        height: 50,
        color: const Color.fromRGBO(0, 0, 0, 0)
      ),
    );
  }
}
