import 'package:ecommerce_assignment/core/exceptions/auth_exception.dart';
import 'package:ecommerce_assignment/features/auth/domain/entities/user.dart';
import 'package:ecommerce_assignment/features/auth/domain/repositories/auth_repository.dart';
import 'package:ecommerce_assignment/features/auth/presentation/state/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

export 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<User?> checkAuth() async {
    try {
      User user = await authRepository.getCurrentUser();
      emit(AuthAuthenticated(user));
      return user;
    } catch (_) {
      emit(AuthLoggedOut());
    }
    return null;
  }

  Future<void> login({required String email, required String password}) async {
    if (state is AuthLoading) return;

    emit(AuthLoading());
    try {
      User user = await authRepository.loginWithEmailPass(email: email, password: password);
      emit(AuthAuthenticated(user));
    } on AuthException catch (e) {
      e is IncompleteProfileException ? emit(ProfileSetupState(email)) : emit(AuthError(e.message));
    }
  }

  Future<void> signup({required String email, required String password}) async {
    if (state is AuthLoading) return;

    emit(AuthLoading());
    try {
      await authRepository.signupWithEmailPass(email: email, password: password);
      emit(ProfileSetupState(email));
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    }
  }

  Future<void> logout() async {
    if (state is AuthLoading) return;

    emit(AuthLoading());
    try {
      await authRepository.logout();
      emit(AuthLoggedOut());
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    }
  }

  Future<void> createProfile(User user) async {
    if (state is AuthLoading) return;

    emit(AuthLoading());
    try {
      await authRepository.createProfile(user);
      emit(AuthAuthenticated(user));
    } on AuthException catch (e) {
      emit(AuthError(e.message));
    }
  }
}
