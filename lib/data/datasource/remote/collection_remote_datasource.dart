import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../domain/entities/collection_entity.dart';
import '../../models/collection_model.dart';

abstract class CollectionRemoteDataSource {
  Future<List<CollectionModel>> getCollections({
    required CollectionType type,
    DateTime? fromDate,
    DateTime? toDate,
  });

  Future<CollectionModel> createCollection(CollectionModel model);

  Future<CollectionModel> getCollectionById(String id);
}

class CollectionRemoteDataSourceImpl implements CollectionRemoteDataSource {
  CollectionRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<CollectionModel>> getCollections({
    required CollectionType type,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final response = await _dio.get(
      ApiConstants.collections,
      queryParameters: {
        'type': type.code,
        if (fromDate != null) 'from_date': fromDate.toIso8601String(),
        if (toDate != null) 'to_date': toDate.toIso8601String(),
      },
    );
    final data = response.data as List<dynamic>;
    return data
        .map((e) => CollectionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<CollectionModel> createCollection(CollectionModel model) async {
    final response = await _dio.post(
      ApiConstants.collections,
      data: model.toJson(),
    );
    return CollectionModel.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<CollectionModel> getCollectionById(String id) async {
    final response = await _dio.get(
      ApiConstants.collectionById.replaceAll('{id}', id),
    );
    return CollectionModel.fromJson(response.data as Map<String, dynamic>);
  }
}
