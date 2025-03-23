import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/config/router/app_router.dart';
import 'package:ecommerce_assignment/config/theme/theme_cubit.dart';
import 'package:ecommerce_assignment/core/overlays/dialogs.dart';
import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/auth/domain/entities/user.dart';
import 'package:ecommerce_assignment/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce_assignment/features/auth/presentation/state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const route = "/profile";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is AuthAuthenticated) {
            final User user = state.user;
            return Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40.sp)),
                  VerticalSpacing(20),
                  Text(user.name, style: Theme.of(context).textTheme.titleSmall),
                  VerticalSpacing(10),
                  Text(user.email, style: Theme.of(context).textTheme.bodyMedium),
                  VerticalSpacing(10),
                  Text(user.phone, style: Theme.of(context).textTheme.bodyMedium),
                  VerticalSpacing(10),
                  Text(user.address, style: Theme.of(context).textTheme.bodyMedium),
                  VerticalSpacing(10),
                  Row(
                    children: [
                      Text("Dark Theme", style: Theme.of(context).textTheme.bodyMedium),
                      Spacer(),
                      BlocBuilder<ThemeCubit, ThemeMode>(
                        builder: (context, state) {
                          return Switch(
                            activeColor: Theme.of(context).colorScheme.onPrimary,
                            activeTrackColor: Theme.of(context).colorScheme.primary,
                            inactiveTrackColor: Theme.of(context).colorScheme.primary,
                            inactiveThumbColor: Theme.of(context).colorScheme.onPrimary,
                            trackOutlineWidth: WidgetStatePropertyAll<double>(0),
                            value: state == ThemeMode.dark,
                            onChanged: (value) {
                              getIt<ThemeCubit>().changeTheme();
                            },
                          );
                        },
                      ),
                    ],
                  ),
                  VerticalSpacing(20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        AppDialogs.showConfirmationDialog(
                          context,
                          'Are you sure you want to logout?',
                          () {
                            context.read<AuthCubit>().logout();
                            AppRouter.popAllAndPush(context, LoginScreen.route);
                          },
                        );
                      },
                      child: Text("Logout"),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text("User not authenticated"));
          }
        },
      ),
    );
  }
}
