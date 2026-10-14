import 'package:recipe_app/models/user.dart';

/// Contract for authentication. Teammates can implement this with FastAPI later.
abstract class AuthService {
  Future<User?> getCurrentUser();

  Future<User> login({required String email, required String password});

  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  });

  Future<void> sendPasswordReset(String email);

  Future<User> signInWithGoogle();

  Future<void> logout();
}
