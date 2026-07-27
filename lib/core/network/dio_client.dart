import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants/api_constants.dart';
import '../constants/app_constants.dart';
import '../services/secure_storage_service.dart';
import '../utils/logger.dart';
import 'api_interceptor.dart';

final dioProvider = Provider<Dio>((ref) {
  final secureStorage = ref.watch(secureStorageServiceProvider);
  return DioClient(secureStorage: secureStorage).dio;
});

class DioClient {
  DioClient({required SecureStorageService secureStorage}) {
    dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: AppConstants.apiTimeout,
        receiveTimeout: AppConstants.apiTimeout,
        sendTimeout: AppConstants.apiTimeout,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      ApiInterceptor(secureStorage: secureStorage),
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => AppLogger.debug(obj.toString()),
      ),
    ]);
  }

  late final Dio dio;
}
