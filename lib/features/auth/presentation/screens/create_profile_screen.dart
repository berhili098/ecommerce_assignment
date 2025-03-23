import 'package:ecommerce_assignment/config/di/dependency_injection.dart';
import 'package:ecommerce_assignment/config/router/app_router.dart';
import 'package:ecommerce_assignment/core/overlays/toast.dart';
import 'package:ecommerce_assignment/core/utils/helpers/form_validators.dart';
import 'package:ecommerce_assignment/core/widgets/button.dart';
import 'package:ecommerce_assignment/core/widgets/form_field.dart';
import 'package:ecommerce_assignment/core/widgets/spacing.dart';
import 'package:ecommerce_assignment/features/auth/domain/entities/user.dart';
import 'package:ecommerce_assignment/features/auth/presentation/state/auth_cubit.dart';
import 'package:ecommerce_assignment/features/main/presentation/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  static const route = "/create-profile";

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _emailController.text = (getIt<AuthCubit>().state as ProfileSetupState).email;
  }

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Complete Your Profile")),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            AppRouter.popAllAndPush(context, MainScreen.route);
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
                  AppFormField(controller: _emailController, readOnly: true, labelText: "Email"),
                  VerticalSpacing(20),
                  AppFormField(
                    controller: _nameController,
                    labelText: "Full Name",
                    hintText: "Enter your full name",
                    validator: FormValidators.name,
                  ),
                  VerticalSpacing(20),
                  AppFormField(
                    controller: _phoneController,
                    labelText: "Phone Number",
                    hintText: "Enter your phone number",
                    keyboardType: TextInputType.phone,
                    validator: FormValidators.phone,
                  ),
                  VerticalSpacing(20),
                  AppFormField(
                    controller: _addressController,
                    labelText: "Address",
                    hintText: "Enter your address",
                    validator: FormValidators.address,
                  ),
                  VerticalSpacing(40),
                  BlocBuilder<AuthCubit, AuthState>(
                    builder: (context, state) {
                      return AppElevatedButton(
                        onPressed: () async {
                          final name = _nameController.text.trim();
                          final phone = _phoneController.text.trim();
                          final address = _addressController.text.trim();

                          if (_formKey.currentState!.validate()) {
                            final User user = User(
                              id: "", // id will be replaced by the repository with the firebase user id
                              name: name,
                              email: _emailController.text.trim(),
                              phone: phone,
                              address: address,
                            );
                            getIt<AuthCubit>().createProfile(user);
                          }
                        },
                        text: "Continue",
                        loading: state is AuthLoading,
                      );
                    },
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
