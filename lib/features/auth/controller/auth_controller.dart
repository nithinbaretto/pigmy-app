import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/usecases/login_usecase.dart';
import '../../../shared/providers/providers.dart';
import '../model/auth_state.dart';

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(ref.watch(loginUseCaseProvider));
});

class AuthController extends StateNotifier<AuthState> {
  AuthController(this._loginUseCase) : super(const AuthState());

  final LoginUseCase _loginUseCase;

  void updateUsername(String value) => state = state.copyWith(username: value);
  void updatePassword(String value) => state = state.copyWith(password: value);

  Future<void> login() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _loginUseCase(
      username: state.username,
      password: state.password,
    );
    result.when(
      success: (_) => state = state.copyWith(isLoading: false, isAuthenticated: true),
      onFailure: (f) => state = state.copyWith(isLoading: false, error: f.message),
    );
  }
}
