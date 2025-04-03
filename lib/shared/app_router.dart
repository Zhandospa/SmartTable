import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:onay/Features/Auth/Presentation/logins_screen.dart';
import 'package:onay/Features/Auth/data/service.dart';
import 'package:onay/Features/home/presentation/screens/food_screen.dart';
import 'package:onay/Features/home/presentation/screens/home_screen.dart';
import 'package:onay/Features/home/presentation/screens/basket_screen.dart';


part 'app_router.gr.dart'; // Файл будет сгенерирован автоматически
@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  final logger = Logger();

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page),
        AutoRoute(page: LoginRoute.page, initial: true),
        AutoRoute(
          page: FoodRoute.page,
          path: '/food/:categoryId/:categoryTitle', // Добавляем параметры в маршрут
        ),
        AutoRoute(page: BasketRoute.page)
      ];
}

/// Гард (перехватчик) для проверки авторизации
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final isLoggedIn = AuthService.isLoggedIn(); // Проверяем авторизацию

    if (isLoggedIn) {
      resolver.next(true); // Разрешаем переход на HomeScreen
    } else {
      router.replace(const LoginRoute()); // Перенаправляем на LoginScreen
    }
  }
}
