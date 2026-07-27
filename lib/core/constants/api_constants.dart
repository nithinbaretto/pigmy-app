class ApiConstants {
  ApiConstants._();

  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://api.pigmy.example.com/v1',
  );

  // Auth
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // Collections (generic endpoint — type passed as query param)
  static const String collections = '/collections';
  static const String collectionById = '/collections/{id}';

  // Transactions
  static const String transactions = '/transactions';
  static const String transactionById = '/transactions/{id}';

  // Sync
  static const String syncPush = '/sync/push';
  static const String syncPull = '/sync/pull';

  // Bank Details
  static const String bankDetails = '/bank-details';

  // Summary
  static const String summary = '/summary';
}
