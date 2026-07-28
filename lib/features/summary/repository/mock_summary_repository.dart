import '../../collection/repository/mock_customer_repository.dart';
import '../../transactions/repository/mock_transaction_repository.dart';
import '../model/summary_data.dart';
import 'summary_repository.dart';

/// Mock summary repository derived from customer and transaction data.
class MockSummaryRepository implements SummaryRepository {
  MockSummaryRepository(this._customerRepo, this._transactionRepo);

  final MockCustomerRepository _customerRepo;
  final MockTransactionRepository _transactionRepo;

  @override
  Future<SummaryData> getSummary() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    final customers = await _customerRepo.getCustomers();
    final totalCollected = await _transactionRepo.getTotalAmount();
    final totalDue = customers.fold<double>(0, (sum, c) => sum + c.todayDue);

    return SummaryData(
      todayCollection: totalDue,
      collectedAmount: totalCollected,
      pending: totalDue - totalCollected,
      customersVisited: 10,
      totalCustomers: customers.length,
    );
  }
}
