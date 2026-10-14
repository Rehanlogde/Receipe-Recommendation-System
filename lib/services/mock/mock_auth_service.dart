import 'package:recipe_app/core/constants/app_constants.dart';
import 'package:recipe_app/models/user.dart';
import 'package:recipe_app/services/auth_service.dart';
import 'package:recipe_app/services/mock/mock_data.dart';

class MockAuthService implements AuthService {
  User? _currentUser;

  @override
  Future<User?> getCurrentUser() async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    return _currentUser;
  }

  @override
  Future<User> login({required String email, required String password}) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    _currentUser = User(
      id: 'user-local',
      name: email.split('@').first,
      email: email,
    );
    return _currentUser!;
  }

  @override
  Future<User> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    _currentUser = User(id: 'user-local', name: name, email: email);
    return _currentUser!;
  }

  @override
  Future<void> sendPasswordReset(String email) async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
  }

  @override
  Future<User> signInWithGoogle() async {
    await Future<void>.delayed(AppConstants.mockNetworkDelay);
    _currentUser = MockData.demoUser;
    return _currentUser!;
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    _currentUser = null;
  }
}
