import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/transaction.dart';
import '../../../shared/providers/repository_providers.dart';

final transactionsProvider = FutureProvider<List<Transaction>>((ref) async {
  final repo = ref.watch(transactionRepositoryProvider);
  return repo.getTransactions();
});

final transactionTotalProvider = FutureProvider<double>((ref) async {
  final repo = ref.watch(transactionRepositoryProvider);
  return repo.getTotalAmount();
});
