import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/repository/auth_repository.dart';
import '../../features/auth/repository/mock_auth_repository.dart';
import '../../features/collection/repository/customer_repository.dart';
import '../../features/collection/repository/mock_customer_repository.dart';
import '../../features/summary/repository/mock_summary_repository.dart';
import '../../features/summary/repository/summary_repository.dart';
import '../../features/transactions/repository/mock_transaction_repository.dart';
import '../../features/transactions/repository/transaction_repository.dart';

// ── Singleton mock instances (shared in-memory state) ─────────────────────

final _mockCustomerRepo = MockCustomerRepository();
final _mockTransactionRepo = MockTransactionRepository(_mockCustomerRepo);
final _mockSummaryRepo = MockSummaryRepository(_mockCustomerRepo, _mockTransactionRepo);
final _mockAuthRepo = MockAuthRepository();

// ── Repository providers — swap implementations in future phases ──────────

final authRepositoryProvider = Provider<AuthRepository>((ref) => _mockAuthRepo);

final customerRepositoryProvider = Provider<CustomerRepository>((ref) => _mockCustomerRepo);

final transactionRepositoryProvider = Provider<TransactionRepository>((ref) => _mockTransactionRepo);

final summaryRepositoryProvider = Provider<SummaryRepository>((ref) => _mockSummaryRepo);

// Expose mock repos for cross-feature operations (e.g. save collection)
final mockCustomerRepositoryProvider = Provider<MockCustomerRepository>((ref) => _mockCustomerRepo);

final mockTransactionRepositoryProvider =
    Provider<MockTransactionRepository>((ref) => _mockTransactionRepo);
