import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login({
    required String username,
    required String password,
  });

  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<UserModel> login({
    required String username,
    required String password,
  }) async {
    final response = await _dio.post(
      ApiConstants.login,
      data: {'username': username, 'password': password},
    );
    return UserModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<void> logout() async {
    await _dio.post(ApiConstants.logout);
  }
}
