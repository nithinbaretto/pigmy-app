class AuthState {
  const AuthState({
    this.username = '',
    this.password = '',
    this.isLoading = false,
    this.isAuthenticated = false,
    this.error,
  });

  final String username;
  final String password;
  final bool isLoading;
  final bool isAuthenticated;
  final String? error;

  AuthState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    bool? isAuthenticated,
    String? error,
  }) {
    return AuthState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      error: error,
    );
  }
}
