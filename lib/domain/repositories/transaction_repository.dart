import '../../core/utils/result.dart';
import '../entities/collection_entity.dart';
import '../entities/transaction_entity.dart';

abstract class TransactionRepository {
  Future<Result<List<TransactionEntity>>> getTransactions({
    CollectionType? type,
    DateTime? fromDate,
    DateTime? toDate,
  });

  Future<Result<TransactionEntity>> getTransactionById(String id);
}
