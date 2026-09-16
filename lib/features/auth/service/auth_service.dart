import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../model/auth_api_models.dart';

class AuthService {
  AuthService(this._dio);

  final Dio _dio;

  Future<RegisterDeviceResponse> registerDevice({
    required String deviceId,
    required String bankCode,
    required String agentCode,
    required String agentName,
  }) async {
    final response = await _dio.post<Map<String, dynamic>>(
      ApiConstants.registerDevice,
      data: {
        'deviceId': deviceId,
        'bankCode': bankCode,
        'agentCode': agentCode,
        'agentName': agentName,
      },
    );
    return RegisterDeviceResponse.fromJson(_asMap(response.data));
  }

  Future<CheckDeviceResponse> checkDevice({
    required String deviceId,
    required String bankCode,
    required String agentCode,
  }) async {
    final payload = {
      'deviceId': deviceId,
      'bankCode': bankCode,
      'agentCode': agentCode,
    };
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.checkDevice,
      queryParameters: payload,
      data: payload,
    );
    return CheckDeviceResponse.fromJson(_asMap(response.data));
  }

  Future<DeviceDetailsResponse> detailsByDeviceId(String deviceId) async {
    final payload = {'deviceId': deviceId};
    final response = await _dio.get<Map<String, dynamic>>(
      ApiConstants.detailsByDeviceId,
      queryParameters: payload,
      data: payload,
    );
    return DeviceDetailsResponse.fromJson(_asMap(response.data));
  }

  Map<String, dynamic> _asMap(dynamic data) {
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    return <String, dynamic>{};
  }
}
