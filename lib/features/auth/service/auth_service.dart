import 'package:dio/dio.dart';

/// Placeholder auth service for future API integration.
class AuthService {
  AuthService(this._dio);

  final Dio _dio; // ignore: unused_field — used when API is integrated

  Future<Map<String, dynamic>> login(String username, String password) async {
    // Future: POST to API
    throw UnimplementedError('API integration pending');
  }
}
