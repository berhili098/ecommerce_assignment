import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/config/router/app_router.dart';
import 'package:ecommerce_assignment/core/overlays/toast.dart';
import 'package:ecommerce_assignment/core/utils/helpers/form_validators.dart';
import 'package:ecommerce_assignment/core/widgets/button.dart';
import 'package:ecommerce_assignment/core/widgets/form_field.dart';
import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/auth/presentation/screens/create_profile_screen.dart';
import 'package:ecommerce_assignment/features/auth/presentation/screens/login_screen.dart';
import 'package:ecommerce_assignment/features/auth/presentation/state/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  static const route = "/signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
      appBar: AppBar(title: Text("Signup")),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (getIt<AuthCubit>().state is ProfileSetupState) {
            AppRouter.pushReplacementNamed(context, CreateProfileScreen.route);
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
                          if (email.isNotEmpty && password.isNotEmpty) {
                            getIt<AuthCubit>().signup(email: email, password: password);
                          }
                        },
                        text: "Signup",
                        loading: state is AuthLoading,
                      );
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      AppRouter.popAllAndPush(context, LoginScreen.route);
                    },
                    child: Text("Already have an account? Login up"),
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
