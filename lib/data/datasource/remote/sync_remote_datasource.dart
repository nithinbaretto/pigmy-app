import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';

abstract class SyncRemoteDataSource {
  Future<void> pushChanges(List<Map<String, dynamic>> changes);

  Future<List<Map<String, dynamic>>> pullChanges({DateTime? since});
}

class SyncRemoteDataSourceImpl implements SyncRemoteDataSource {
  SyncRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<void> pushChanges(List<Map<String, dynamic>> changes) async {
    await _dio.post(ApiConstants.syncPush, data: {'changes': changes});
  }

  @override
  Future<List<Map<String, dynamic>>> pullChanges({DateTime? since}) async {
    final response = await _dio.get(
      ApiConstants.syncPull,
      queryParameters: {
        if (since != null) 'since': since.toIso8601String(),
      },
    );
    return (response.data as List<dynamic>)
        .map((e) => e as Map<String, dynamic>)
        .toList();
  }
}
