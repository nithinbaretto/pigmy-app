import 'package:isar/isar.dart';

import '../../../core/services/isar_service.dart';
import '../../../domain/entities/collection_entity.dart';
import '../../models/transaction_model.dart';

abstract class TransactionLocalDataSource {
  Future<List<TransactionModel>> getTransactions({
    CollectionType? type,
    DateTime? fromDate,
    DateTime? toDate,
  });

  Future<TransactionModel?> getByServerId(String serverId);

  Future<int> save(TransactionModel model);
}

class TransactionLocalDataSourceImpl implements TransactionLocalDataSource {
  TransactionLocalDataSourceImpl(this._isarService);

  final IsarService _isarService;

  @override
  Future<List<TransactionModel>> getTransactions({
    CollectionType? type,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    var results = await _isarService.instance.transactionModels
        .where()
        .anyId()
        .findAll();

    if (type != null) {
      results = results.where((t) => t.collectionTypeCode == type.code).toList();
    }
    if (fromDate != null) {
      results = results
          .where((t) => !t.transactionDate.isBefore(fromDate))
          .toList();
    }
    if (toDate != null) {
      results = results.where((t) => !t.transactionDate.isAfter(toDate)).toList();
    }

    results.sort((a, b) => b.transactionDate.compareTo(a.transactionDate));
    return results;
  }

  @override
  Future<TransactionModel?> getByServerId(String serverId) async {
    return _isarService.instance.transactionModels
        .filter()
        .serverIdEqualTo(serverId)
        .findFirst();
  }

  @override
  Future<int> save(TransactionModel model) async {
    return _isarService.instance.writeTxn(() async {
      return _isarService.instance.transactionModels.put(model);
    });
  }
}
