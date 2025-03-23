import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_assignment/core/exceptions/auth_exception.dart';
import 'package:ecommerce_assignment/core/extensions/string_extensions.dart';
import 'package:ecommerce_assignment/features/auth/data/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:uuid/uuid.dart';

abstract class AuthDataSource {
  Future<UserModel> loginWithEmailPass({required String email, required String password});
  Future<void> signupWithEmailPass({required String email, required String password});
  Future<void> logout();
  Future<void> createProfile(UserModel user);
  Future<UserModel> getCurrentUser();
}

class AuthRemoteDataSource implements AuthDataSource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<UserModel> loginWithEmailPass({required String email, required String password}) async {
    try {
      final UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const AuthException('User not found');
      }

      final userSnapshot = await _firestore.collection('users').doc(userCredential.user!.uid).get();

      if (!userSnapshot.exists) {
        throw const IncompleteProfileException();
      }

      final user = UserModel.fromJson(userSnapshot.data()!);

      return user;
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code.errorToPresentableString);
    }
  }

  @override
  Future<void> signupWithEmailPass({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code.errorToPresentableString);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(e.code.errorToPresentableString);
    }
  }

  @override
  Future<void> createProfile(UserModel user) async {
    try {
      final String uid = _firebaseAuth.currentUser?.uid ?? Uuid().v4();
      await _firestore.collection('users').doc(uid).set(user.toJson());
    } on FirebaseException catch (e) {
      throw AuthException(e.code.errorToPresentableString);
    }
  }

  @override
  Future<UserModel> getCurrentUser() async {
    final currentUser = _firebaseAuth.currentUser;

    if (currentUser == null) {
      throw const AuthException('No user');
    }

    final userSnapshot = await _firestore.collection('users').doc(currentUser.uid).get();

    if (!userSnapshot.exists) {
      throw const IncompleteProfileException();
    }

    final user = UserModel.fromJson(userSnapshot.data()!);

    return user;
  }
}
