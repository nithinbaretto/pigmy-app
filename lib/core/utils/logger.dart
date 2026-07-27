import 'package:flutter/foundation.dart';

class AppLogger {
  AppLogger._();

  static void debug(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      debugPrint('[DEBUG] $message');
      if (error != null) debugPrint('[DEBUG] Error: $error');
      if (stackTrace != null) debugPrint('[DEBUG] $stackTrace');
    }
  }

  static void info(String message) {
    if (kDebugMode) debugPrint('[INFO] $message');
  }

  static void warning(String message, [Object? error]) {
    if (kDebugMode) {
      debugPrint('[WARN] $message');
      if (error != null) debugPrint('[WARN] Error: $error');
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    debugPrint('[ERROR] $message');
    if (error != null) debugPrint('[ERROR] Error: $error');
    if (stackTrace != null) debugPrint('[ERROR] $stackTrace');
  }
}
