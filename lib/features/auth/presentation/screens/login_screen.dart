import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/config/router/app_router.dart';
import 'package:ecommerce_assignment/core/overlays/toast.dart';
import 'package:ecommerce_assignment/core/utils/helpers/form_validators.dart';
import 'package:ecommerce_assignment/core/widgets/button.dart';
import 'package:ecommerce_assignment/core/widgets/form_field.dart';
import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/auth/presentation/screens/create_profile_screen.dart';
import 'package:ecommerce_assignment/features/auth/presentation/screens/signup_screen.dart';
import 'package:ecommerce_assignment/features/auth/presentation/state/auth_cubit.dart';
import 'package:ecommerce_assignment/features/main/presentation/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const route = "/login";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            AppRouter.popAllAndPush(context, MainScreen.route);
          } else if (state is ProfileSetupState) {
            AppRouter.pushNamed(context, CreateProfileScreen.route);
          } else if (state is AuthError) {
            AppToast.show(state.message);
          }
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppFormField(
                    controller: _emailController,
                    labelText: "Email",
                    hintText: "Enter your email",
                    validator: FormValidators.email,
                  ),
                  VerticalSpacing(20),
                  AppFormField(
                    controller: _passwordController,
                    obscureText: true,
                    labelText: "Password",
                    hintText: "Enter your password",
                    validator: FormValidators.password,
                  ),

                  VerticalSpacing(40),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return AppElevatedButton(
                        onPressed: () async {
                          final email = _emailController.text.trim();
                          final password = _passwordController.text.trim();
                          if (_formKey.currentState?.validate() ?? false) {
                            getIt<AuthCubit>().login(email: email, password: password);
                          }
                        },
                        text: "Login",
                        loading: state is AuthLoading,
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () => AppRouter.pushNamed(context, SignupScreen.route),
                    child: Text("Don't have an account? Sign up"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
