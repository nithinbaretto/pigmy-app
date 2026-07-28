import '../../collection/repository/mock_customer_repository.dart';
import '../model/transaction.dart';
import 'transaction_repository.dart';

/// In-memory mock transaction repository.
class MockTransactionRepository implements TransactionRepository {
  MockTransactionRepository(this._customerRepo);

  final MockCustomerRepository _customerRepo;
  final List<Transaction> _transactions = [];

  bool _initialized = false;

  Future<void> _ensureInitialized() async {
    if (_initialized) return;
    final customers = await _customerRepo.getCustomers();
    for (var i = 0; i < 10 && i < customers.length; i++) {
      final c = customers[i];
      _transactions.add(
        Transaction(
          id: 'txn_${i + 1}',
          customerId: c.id,
          customerName: c.customerName,
          pigmyNumber: c.pigmyNumber,
          amount: 500,
          date: DateTime(2024, 2, 1),
          status: TransactionStatus.completed,
        ),
      );
    }
    _initialized = true;
  }

  @override
  Future<List<Transaction>> getTransactions() async {
    await _ensureInitialized();
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_transactions);
  }

  @override
  Future<double> getTotalAmount() async {
    final txns = await getTransactions();
    return txns.fold<double>(0, (sum, t) => sum + t.amount);
  }

  @override
  Future<void> addTransaction(Transaction transaction) async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    _transactions.insert(0, transaction);
  }
}
