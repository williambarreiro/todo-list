import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import './user_repository.dart';
import '../../exceptions/auth_exception.dart';

class UserRepositoryImpl implements UserRepository {
  final FirebaseAuth _firebaseAuth;

  UserRepositoryImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  @override
  Future<User?> register(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        final loginTypes =
            await _firebaseAuth.fetchSignInMethodsForEmail(email);
        if (loginTypes.contains('password')) {
          throw AuthException(message: 'E-mail já em uso.');
        } else {
          throw AuthException(
              message: 'Você já está cadastrado pela conta Google.');
        }
      } else {
        throw AuthException(message: e.message ?? 'Erro ao registrar usuário.');
      }
    }
  }

  @override
  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on PlatformException catch (e) {
      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        throw AuthException(message: 'Login ou senha inválidos');
      }

      throw AuthException(message: e.message ?? 'Erro ao realizar login');
    }
  }
}
