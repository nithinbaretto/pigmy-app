import '../model/auth_api_models.dart';
import '../model/auth_state.dart';
import 'auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  bool _isLoggedIn = false;
  AppMode _appMode = AppMode.online;

  @override
  AppMode get appMode => _appMode;

  @override
  set appMode(AppMode mode) => _appMode = mode;

  @override
  bool get isLoggedIn => _isLoggedIn;

  @override
  Future<AuthActionResult> login({
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _isLoggedIn = true;
    return const AuthActionResult(success: true);
  }

  @override
  Future<AuthActionResult> register({
    required String username,
    required String password,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return const AuthActionResult(success: true);
  }

  @override
  Future<bool> restoreSession() async => _isLoggedIn;

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _isLoggedIn = false;
  }
}
