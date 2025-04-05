import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onay/Features/home/presentation/widgets/inactivity_wrapper.dart';
import 'package:onay/shared/app_router.dart';

const platform = MethodChannel('kiosk_channel');

Future<void> startKioskMode() async {
  try {
    await platform.invokeMethod('startKiosk');
  } catch (e) {
    print('Ошибка запуска киоска: $e');
  }
}

Future<void> setFullScreen() async {
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.black,
    systemNavigationBarContrastEnforced: false,
  ));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kDebugMode) {
    // Только в релизной сборке
    setFullScreen();
    startKioskMode();
  }
  runApp(const ProviderScope(child: InactivityWrapper(child: MyApp())));
}

final appRouter = AppRouter();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setFullScreen(); // Повторное скрытие при открытии
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setFullScreen(); // Снова скрыть панели при возвращении
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: appRouter.config(),
      ),
    );
  }
}
