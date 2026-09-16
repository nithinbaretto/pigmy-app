enum AppMode { online, offline }

class LoginState {
  const LoginState({
    this.username = '',
    this.password = '',
    this.mode = AppMode.online,
    this.isLoading = false,
    this.errorMessage = '',
  });

  final String username;
  final String password;
  final AppMode mode;
  final bool isLoading;
  final String errorMessage;

  LoginState copyWith({
    String? username,
    String? password,
    AppMode? mode,
    bool? isLoading,
    String? errorMessage,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      mode: mode ?? this.mode,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
