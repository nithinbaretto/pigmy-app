import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/register_state.dart';
import '../repository/auth_repository.dart';
import '../../../shared/providers/repository_providers.dart';

final registerControllerProvider =
    StateNotifierProvider<RegisterController, RegisterState>((ref) {
  return RegisterController(ref.watch(authRepositoryProvider));
});

class RegisterController extends StateNotifier<RegisterState> {
  RegisterController(this._repository) : super(const RegisterState());

  final AuthRepository _repository;

  void updateUsername(String value) => state = state.copyWith(username: value);

  void updatePassword(String value) => state = state.copyWith(password: value);

  void updateConfirmPassword(String value) =>
      state = state.copyWith(confirmPassword: value);

  Future<void> register() async {
    if (!state.isFormValid) return;

    state = state.copyWith(isLoading: true);
    await _repository.register(
      username: state.username,
      password: state.password,
    );
    state = state.copyWith(isLoading: false, showSuccess: true);
  }
}
