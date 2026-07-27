import 'package:dio/dio.dart';

import '../constants/storage_keys.dart';
import '../services/secure_storage_service.dart';

class ApiInterceptor extends Interceptor {
  ApiInterceptor({required SecureStorageService secureStorage})
      : _secureStorage = secureStorage;

  final SecureStorageService _secureStorage;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _secureStorage.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      await _secureStorage.delete(StorageKeys.accessToken);
    }
    handler.next(err);
  }
}
