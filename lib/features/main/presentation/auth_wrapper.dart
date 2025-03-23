import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce_assignment/features/auth/presentation/state/auth_cubit.dart';
import 'package:ecommerce_assignment/features/main/presentation/main_screen.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  static const String route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: FutureBuilder(
        future: getIt<AuthCubit>().checkAuth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final user = snapshot.data;
            if (user == null) {
              return LoginScreen();
            }
            return MainScreen();
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
