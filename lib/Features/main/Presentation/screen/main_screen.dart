import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onay/shared/app_router.dart';
import 'package:onay/shared/utils/secret_exit_button.dart';

@RoutePage()
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Главное меню"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () => context.router.push(const HomeRoute()),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Меню",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),

          // 🔐 Скрытая зона выхода (например, внизу справа)
          const Positioned(
            bottom: 24,
            right: 1000,
            child: SecretExitButton(),
          ),
        ],
      ),
    );
  }
}
