import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/hex_background.dart';
import '../../../core/widgets/loading_widget.dart';
import '../controller/customers_controller.dart';

class CustomerDetailsScreen extends ConsumerWidget {
  const CustomerDetailsScreen({super.key, required this.customerId});

  final String customerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customerAsync = ref.watch(customerByIdProvider(customerId));

    return Scaffold(
      body: HexBackground(
        child: Column(
          children: [
            const CommonAppBar(title: AppStrings.customerDetails),
            Expanded(
              child: customerAsync.when(
                loading: () => const LoadingWidget(),
                error: (e, _) => Center(child: Text('$e')),
                data: (customer) {
                  if (customer == null) {
                    return const Center(child: Text('Customer not found'));
                  }
                  return Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _InfoTile(label: AppStrings.pigmyNumber, value: customer.pigmyNumber),
                        _InfoTile(label: AppStrings.name, value: customer.customerName),
                        _InfoTile(label: 'Phone', value: customer.phone),
                        _InfoTile(label: 'Address', value: customer.address),
                        _InfoTile(
                          label: AppStrings.openingBalance,
                          value: AppFormatters.currency(customer.openingBalance),
                        ),
                        _InfoTile(
                          label: AppStrings.todayDue,
                          value: AppFormatters.currency(customer.todayDue),
                        ),
                        _InfoTile(label: 'Status', value: customer.status),
                        const Spacer(),
                        CommonButton(
                          label: 'Collect',
                          onPressed: () => context.push('/collection/$customerId'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  const _InfoTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Flexible(
            child: Text(
              value,
              style: AppTextStyles.bodyMedium,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
