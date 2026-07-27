import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/entities/transaction_entity.dart';
import '../../../domain/usecases/get_transactions_usecase.dart';
import '../../../shared/providers/providers.dart';

class TransactionsState {
  const TransactionsState({
    this.transactions = const [],
    this.isLoading = false,
    this.error,
  });

  final List<TransactionEntity> transactions;
  final bool isLoading;
  final String? error;

  TransactionsState copyWith({
    List<TransactionEntity>? transactions,
    bool? isLoading,
    String? error,
  }) {
    return TransactionsState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

final transactionsControllerProvider =
    StateNotifierProvider<TransactionsController, TransactionsState>((ref) {
  final controller = TransactionsController(ref.watch(getTransactionsUseCaseProvider));
  controller.load();
  return controller;
});

class TransactionsController extends StateNotifier<TransactionsState> {
  TransactionsController(this._getTransactionsUseCase)
      : super(const TransactionsState());

  final GetTransactionsUseCase _getTransactionsUseCase;

  Future<void> load() async {
    state = state.copyWith(isLoading: true, error: null);
    final result = await _getTransactionsUseCase();
    result.when(
      success: (data) =>
          state = state.copyWith(transactions: data, isLoading: false),
      onFailure: (f) =>
          state = state.copyWith(isLoading: false, error: f.message),
    );
  }
}
