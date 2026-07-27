class AppConstants {
  AppConstants._();

  static const String appName = 'Pigmy Collection';
  static const String appVersion = '1.0.0';

  static const Duration apiTimeout = Duration(seconds: 30);
  static const Duration syncInterval = Duration(minutes: 5);

  static const int defaultPageSize = 20;
  static const int maxRetryAttempts = 3;
}
