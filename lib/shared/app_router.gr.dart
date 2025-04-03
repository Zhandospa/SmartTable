// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    BasketRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const BasketScreen(),
      );
    },
    FoodRoute.name: (routeData) {
      final args = routeData.argsAs<FoodRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: FoodScreen(
          key: args.key,
          categoryId: args.categoryId,
          categoryTitle: args.categoryTitle,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomeScreen(),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: LoginScreen(),
      );
    },
  };
}

/// generated route for
/// [BasketScreen]
class BasketRoute extends PageRouteInfo<void> {
  const BasketRoute({List<PageRouteInfo>? children})
      : super(
          BasketRoute.name,
          initialChildren: children,
        );

  static const String name = 'BasketRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [FoodScreen]
class FoodRoute extends PageRouteInfo<FoodRouteArgs> {
  FoodRoute({
    Key? key,
    required int categoryId,
    required String categoryTitle,
    List<PageRouteInfo>? children,
  }) : super(
          FoodRoute.name,
          args: FoodRouteArgs(
            key: key,
            categoryId: categoryId,
            categoryTitle: categoryTitle,
          ),
          initialChildren: children,
        );

  static const String name = 'FoodRoute';

  static const PageInfo<FoodRouteArgs> page = PageInfo<FoodRouteArgs>(name);
}

class FoodRouteArgs {
  const FoodRouteArgs({
    this.key,
    required this.categoryId,
    required this.categoryTitle,
  });

  final Key? key;

  final int categoryId;

  final String categoryTitle;

  @override
  String toString() {
    return 'FoodRouteArgs{key: $key, categoryId: $categoryId, categoryTitle: $categoryTitle}';
  }
}

/// generated route for
/// [ForExampleScreen]
class ForExampleRoute extends PageRouteInfo<void> {
  const ForExampleRoute({List<PageRouteInfo>? children})
      : super(
          ForExampleRoute.name,
          initialChildren: children,
        );

  static const String name = 'ForExampleRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
