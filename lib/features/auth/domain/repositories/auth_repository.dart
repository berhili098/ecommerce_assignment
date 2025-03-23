import 'package:ecommerce_assignment/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> loginWithEmailPass({required String email, required String password});
  Future<void> signupWithEmailPass({required String email, required String password});
  Future<void> logout();
  Future<void> createProfile(User user);
  Future<User> getCurrentUser();
}
