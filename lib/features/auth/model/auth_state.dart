enum AppMode { online, offline }

class LoginState {
  const LoginState({
    this.username = '',
    this.password = '',
    this.mode = AppMode.online,
    this.isLoading = false,
  });

  final String username;
  final String password;
  final AppMode mode;
  final bool isLoading;

  LoginState copyWith({
    String? username,
    String? password,
    AppMode? mode,
    bool? isLoading,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      mode: mode ?? this.mode,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
