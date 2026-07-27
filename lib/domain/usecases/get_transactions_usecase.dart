import '../../core/utils/result.dart';
import '../entities/collection_entity.dart';
import '../entities/transaction_entity.dart';
import '../repositories/transaction_repository.dart';

class GetTransactionsUseCase {
  GetTransactionsUseCase(this._repository);

  final TransactionRepository _repository;

  Future<Result<List<TransactionEntity>>> call({
    CollectionType? type,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return _repository.getTransactions(
      type: type,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
