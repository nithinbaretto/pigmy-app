import '../model/auth_state.dart';

/// Abstract auth repository — swap [MockAuthRepository] with API impl later.
abstract class AuthRepository {
  Future<bool> login({required String username, required String password});
  Future<bool> register({required String username, required String password});
  Future<void> logout();
  bool get isLoggedIn;
  AppMode get appMode;
  set appMode(AppMode mode);
}
