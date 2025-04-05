import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PinCodeDialog extends StatefulWidget {
  const PinCodeDialog({super.key});

  @override
  State<PinCodeDialog> createState() => _PinCodeDialogState();
}

class _PinCodeDialogState extends State<PinCodeDialog> {
  final TextEditingController _controller = TextEditingController();
  final String _correctPin = '4321';
  String? _error;

  Future<void> _checkPin() async {
    if (_controller.text == _correctPin) {
      Navigator.of(context).pop(); // Закрыть диалог
      const platform = MethodChannel('kiosk_channel');
      try {
        await platform.invokeMethod('stopKiosk');
        debugPrint("Киоск отключён");
      } catch (e) {
        debugPrint("Ошибка выхода из киоска: $e");
      }
    } else {
      setState(() {
        _error = 'Неверный PIN-код';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Введите PIN'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            obscureText: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'PIN',
              errorText: _error,
            ),
            onSubmitted: (_) => _checkPin(),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Отмена'),
        ),
        ElevatedButton(
          onPressed: _checkPin,
          child: const Text('ОК'),
        ),
      ],
    );
  }
}
