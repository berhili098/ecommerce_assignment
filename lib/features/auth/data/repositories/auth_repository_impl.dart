import 'package:ecommerce_assignment/features/auth/data/data_sources/auth_remote_datasource.dart';
import 'package:ecommerce_assignment/features/auth/data/models/user.dart';
import 'package:ecommerce_assignment/features/auth/domain/entities/user.dart';
import 'package:ecommerce_assignment/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource dataSource;

  AuthRepositoryImpl(this.dataSource);

  @override
  Future<User> loginWithEmailPass({required String email, required String password}) async {
    final userModel = await dataSource.loginWithEmailPass(email: email, password: password);
    return userModel.toEntity();
  }

  @override
  Future<void> signupWithEmailPass({required String email, required String password}) async {
    await dataSource.signupWithEmailPass(email: email, password: password);
  }

  @override
  Future<void> logout() async {
    await dataSource.logout();
  }

  @override
  Future<void> createProfile(User user) async {
    await dataSource.createProfile(UserModel.fromEntity(user));
  }

  @override
  Future<User> getCurrentUser() async {
    final userModel = await dataSource.getCurrentUser();
    return userModel.toEntity();
  }
}
