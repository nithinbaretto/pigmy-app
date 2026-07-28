import '../model/auth_state.dart';
import 'auth_repository.dart';

/// Mock auth repository — always succeeds, no validation.
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
  Future<bool> login({required String username, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    _isLoggedIn = true;
    return true;
  }

  @override
  Future<bool> register({required String username, required String password}) async {
    await Future<void>.delayed(const Duration(milliseconds: 800));
    return true;
  }

  @override
  Future<void> logout() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    _isLoggedIn = false;
  }
}
