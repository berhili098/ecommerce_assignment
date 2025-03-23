import 'dart:async';

import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/config/router/app_router.dart';
import 'package:ecommerce_assignment/config/theme/app_themes.dart';
import 'package:ecommerce_assignment/config/theme/theme_cubit.dart';
import 'package:ecommerce_assignment/core/constants/strings.dart';
import 'package:ecommerce_assignment/features/auth/presentation/state/auth_cubit.dart';
import 'package:ecommerce_assignment/features/cart/presentation/state/cart_cubit.dart';
import 'package:ecommerce_assignment/features/orders/presentation/state/order_cubit.dart';
import 'package:ecommerce_assignment/features/products/presentation/state/product/product_cubit.dart';
import 'package:ecommerce_assignment/features/products/presentation/state/review/review_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    await Future.wait([
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]),
      ScreenUtil.ensureScreenSize(),
      injectDependencies(),
    ]);
    runApp(const MyApp());
  }, (dynamic error, StackTrace stackTrace) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<AuthCubit>(), lazy: false),
        BlocProvider(create: (context) => getIt<ProductCubit>()),
        BlocProvider(create: (context) => getIt<CartCubit>()),
        BlocProvider(create: (context) => getIt<OrderCubit>()),
        BlocProvider(create: (context) => getIt<ReviewCubit>()),
        BlocProvider(create: (context) => getIt<ThemeCubit>()),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        minTextAdapt: false,
        splitScreenMode: false,
        designSize: const Size(375, 812),
        builder: (context, _) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, state) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: AppStrings.appName,
                themeMode: state,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                onGenerateRoute: AppRouter.generateRoute,
              );
            },
          );
        },
      ),
    );
  }
}
