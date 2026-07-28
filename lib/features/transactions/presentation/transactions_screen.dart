import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/empty_widget.dart';
import '../../../core/widgets/hex_background.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/transactions_controller.dart';

class TransactionsScreen extends ConsumerWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactionsAsync = ref.watch(transactionsProvider);
    final totalAsync = ref.watch(transactionTotalProvider);

    return Scaffold(
      body: HexBackground(
        showBottom: true,
        child: Column(
          children: [
            const CommonAppBar(title: AppStrings.transactions),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(AppStrings.allTransactions, style: AppTextStyles.titleMedium),
              ),
            ),
            Expanded(
              child: transactionsAsync.when(
                loading: () => const LoadingWidget(),
                error: (e, _) => Center(child: Text('$e')),
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return const EmptyWidget(message: 'No transactions yet');
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: transactions.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final txn = transactions[index];
                      return _TransactionTile(
                        pigmyNumber: txn.pigmyNumber,
                        customerName: txn.customerName,
                        amount: AppFormatters.currencyCompact(txn.amount),
                        date: AppFormatters.date(txn.date),
                        status: txn.status.name,
                      )
                          .animate()
                          .fadeIn(
                            delay: Duration(milliseconds: 40 * index),
                            duration: 300.ms,
                          );
                    },
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: AppColors.border)),
              ),
              child: totalAsync.when(
                loading: () => const SizedBox.shrink(),
                error: (_, __) => const SizedBox.shrink(),
                data: (total) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(AppStrings.total, style: AppTextStyles.titleMedium),
                    Text(
                      AppFormatters.currencyCompact(total),
                      style: AppTextStyles.titleMedium.copyWith(
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.pigmyNumber,
    required this.customerName,
    required this.amount,
    required this.date,
    required this.status,
  });

  final String pigmyNumber;
  final String customerName;
  final String amount;
  final String date;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pigmyNumber,
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.primaryLight),
                ),
                const SizedBox(height: 4),
                Text(customerName, style: AppTextStyles.bodyMedium),
                Text(date, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(amount, style: AppTextStyles.titleMedium),
              Text(
                status,
                style: AppTextStyles.bodySmall.copyWith(
                  color: status == 'completed' ? AppColors.success : AppColors.warning,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
