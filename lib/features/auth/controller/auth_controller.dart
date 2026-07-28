import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/auth_state.dart';
import '../repository/auth_repository.dart';
import '../../../shared/providers/repository_providers.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, LoginState>((ref) {
  return AuthController(ref.watch(authRepositoryProvider));
});

class AuthController extends StateNotifier<LoginState> {
  AuthController(this._repository) : super(const LoginState());

  final AuthRepository _repository;

  void updateUsername(String value) => state = state.copyWith(username: value);

  void updatePassword(String value) => state = state.copyWith(password: value);

  void updateMode(AppMode mode) {
    _repository.appMode = mode;
    state = state.copyWith(mode: mode);
  }

  Future<bool> login() async {
    state = state.copyWith(isLoading: true);
    final success = await _repository.login(
      username: state.username,
      password: state.password,
    );
    state = state.copyWith(isLoading: false);
    return success;
  }

  Future<void> logout() async {
    await _repository.logout();
    state = const LoginState();
  }
}
