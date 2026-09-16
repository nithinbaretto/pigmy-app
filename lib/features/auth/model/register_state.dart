class RegisterState {
  const RegisterState({
    this.username = '',
    this.password = '',
    this.confirmPassword = '',
    this.isLoading = false,
    this.showSuccess = false,
    this.errorMessage = '',
  });

  final String username;
  final String password;
  final String confirmPassword;
  final bool isLoading;
  final bool showSuccess;
  final String errorMessage;

  bool get isFormValid =>
      username.trim().isNotEmpty &&
      password.trim().isNotEmpty &&
      confirmPassword.trim().isNotEmpty &&
      password == confirmPassword;

  String get confirmLabel =>
      confirmPassword.isNotEmpty ? 'Confirm' : 'Confirm Password';

  RegisterState copyWith({
    String? username,
    String? password,
    String? confirmPassword,
    bool? isLoading,
    bool? showSuccess,
    String? errorMessage,
  }) {
    return RegisterState(
      username: username ?? this.username,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isLoading: isLoading ?? this.isLoading,
      showSuccess: showSuccess ?? this.showSuccess,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
