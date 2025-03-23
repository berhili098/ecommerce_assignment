import 'package:ecommerce_assignment/core/exceptions/router_exceptions.dart';
import 'package:ecommerce_assignment/core/widgets/button.dart';
import 'package:ecommerce_assignment/features/auth/presentation/screens/create_profile_screen.dart';
import 'package:ecommerce_assignment/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce_assignment/features/auth/presentation/screens/signup_screen.dart';
import 'package:ecommerce_assignment/features/cart/presentation/screens/cart_screen.dart';
import 'package:ecommerce_assignment/features/main/presentation/auth_wrapper.dart';
import 'package:ecommerce_assignment/features/main/presentation/main_screen.dart';
import 'package:ecommerce_assignment/features/orders/presentation/screens/checkout_Screen.dart';
import 'package:ecommerce_assignment/features/orders/presentation/screens/orders_screen.dart';
import 'package:ecommerce_assignment/features/products/domain/entiities/product.dart';
import 'package:ecommerce_assignment/features/products/presentation/screens/product_detail_screen.dart';
import 'package:ecommerce_assignment/features/products/presentation/screens/review_screen.dart';
import 'package:flutter/material.dart' hide Stack;

abstract class AppRouter {
  static final _Stack<String?> _routesHistory = _Stack([LoginScreen.route]);
  static String? get currentRoute => _routesHistory.peek;

  static Future<T?> pushNamed<T extends Object?>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) async {
    if (!context.mounted) return null;

    _routesHistory.push(routeName);
    return await Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  static Future goHome(BuildContext context) async {
    if (!context.mounted) return null;

    _routesHistory.clear();

    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    _routesHistory.push(MainScreen.route);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    BuildContext context,
    String routeName, {
    TO? result,
    Object? arguments,
  }) async {
    _routesHistory.pop();
    if (!context.mounted) return null;

    _routesHistory.push(routeName);
    return await Navigator.pushReplacementNamed<T, TO>(
      context,
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  static void popAllAndPush(BuildContext context, String routeName) {
    _routesHistory.clear();
    _routesHistory.push(routeName);
    Navigator.popUntil(context, (route) => false);
    Navigator.pushNamed(context, routeName);
  }

  static void popRoute(BuildContext context, [result]) {
    _routesHistory.pop();
    Navigator.pop(context, result);
  }

  static void popDialogOrSheetOrDrawer(BuildContext context, [result]) {
    Navigator.pop(context, result);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      switch (settings.name) {
        case AuthWrapper.route:
          return MaterialPageRoute(builder: (_) => const AuthWrapper());
        case LoginScreen.route:
          return MaterialPageRoute(builder: (_) => const LoginScreen());
        case SignupScreen.route:
          return MaterialPageRoute(builder: (_) => const SignupScreen());
        case CreateProfileScreen.route:
          return MaterialPageRoute(builder: (_) => const CreateProfileScreen());
        case MainScreen.route:
          return MaterialPageRoute(builder: (_) => const MainScreen());
        case CartScreen.route:
          return MaterialPageRoute(builder: (_) => const CartScreen());
        case OrdersScreen.route:
          return MaterialPageRoute(builder: (_) => const OrdersScreen());
        case CheckoutScreen.route:
          return MaterialPageRoute(builder: (_) => const CheckoutScreen());
        case ProductDetailScreen.route:
          if (settings.arguments is! Product) {
            throw RouterExceptions('ProductDetailScreen requires Product as argument');
          }
          final product = settings.arguments as Product;
          return MaterialPageRoute(builder: (_) => ProductDetailScreen(product: product));
        case ReviewInputScreen.route:
          if (settings.arguments is! int) {
            throw RouterExceptions('ReviewInputScreen requires ProductId as argument');
          }
          final productId = settings.arguments as int;
          return MaterialPageRoute(builder: (_) => ReviewInputScreen(productId: productId));

        default:
          throw RouterExceptions('Route(${settings.name}) not found');
      }
    } on RouterExceptions catch (e) {
      return MaterialPageRoute(
        builder:
            (ctx) => Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(e.message),
                    AppElevatedButton(onPressed: () => AppRouter.popRoute(ctx), text: 'Go Back'),
                  ],
                ),
              ),
            ),
      );
    }
  }
}

/// This Stack class is used in AppRouter class
class _Stack<E> {
  _Stack(List<E> list) {
    _list = list;
  }

  late final List<E> _list;

  void push(E value) => _list.add(value);

  E? pop() => _list.isNotEmpty ? _list.removeLast() : null;

  void clear() => _list.clear();

  E? get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}
