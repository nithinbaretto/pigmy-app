import '../model/auth_api_models.dart';
import '../model/auth_state.dart';

abstract class AuthRepository {
  Future<AuthActionResult> login({
    required String username,
    required String password,
  });

  Future<AuthActionResult> register({
    required String username,
    required String password,
  });

  Future<void> logout();

  Future<bool> restoreSession();

  bool get isLoggedIn;

  AppMode get appMode;
  set appMode(AppMode mode);
}
