import '../model/transaction.dart';

/// Abstract transaction repository — swap [MockTransactionRepository] with API impl later.
abstract class TransactionRepository {
  Future<List<Transaction>> getTransactions();
  Future<double> getTotalAmount();
  Future<void> addTransaction(Transaction transaction);
}
