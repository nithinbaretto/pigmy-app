import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../../../domain/entities/collection_entity.dart';
import '../../models/transaction_model.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> getTransactions({
    CollectionType? type,
    DateTime? fromDate,
    DateTime? toDate,
  });

  Future<TransactionModel> getTransactionById(String id);
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  TransactionRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<TransactionModel>> getTransactions({
    CollectionType? type,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final response = await _dio.get(
      ApiConstants.transactions,
      queryParameters: {
        if (type != null) 'type': type.code,
        if (fromDate != null) 'from_date': fromDate.toIso8601String(),
        if (toDate != null) 'to_date': toDate.toIso8601String(),
      },
    );
    final data = response.data as List<dynamic>;
    return data
        .map((e) => TransactionModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<TransactionModel> getTransactionById(String id) async {
    final response = await _dio.get(
      ApiConstants.transactionById.replaceAll('{id}', id),
    );
    return TransactionModel.fromJson(response.data as Map<String, dynamic>);
  }
}
