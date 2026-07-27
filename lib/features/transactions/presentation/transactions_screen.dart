import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/formatters.dart';
import '../../../core/widgets/empty_state_widget.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../controller/transactions_controller.dart';
import '../widgets/transaction_list_tile.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(transactionsControllerProvider);

    return AppScaffold(
      title: 'Transactions',
      body: _buildBody(ref, state),
    );
  }

  Widget _buildBody(WidgetRef ref, TransactionsState state) {
    if (state.isLoading) return const LoadingWidget();
    if (state.error != null) {
      return AppErrorWidget(
        message: state.error!,
        onRetry: () => ref.read(transactionsControllerProvider.notifier).load(),
      );
    }
    if (state.transactions.isEmpty) {
      return const EmptyStateWidget(message: 'No transactions found');
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: state.transactions.length,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final tx = state.transactions[index];
        return TransactionListTile(
          title: tx.customerName,
          subtitle: '${tx.collectionType.label} · ${tx.accountNumber}',
          amount: Formatters.currency(tx.amount),
          date: Formatters.date(tx.transactionDate),
        );
      },
    );
  }
}
