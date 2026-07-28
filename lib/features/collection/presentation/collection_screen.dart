import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/common_app_bar.dart';
import '../../../core/widgets/common_button.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../transactions/model/transaction.dart';
import '../../transactions/controller/transactions_controller.dart';
import '../controller/collection_controller.dart';
import '../controller/customers_controller.dart';

class CollectionScreen extends ConsumerStatefulWidget {
  const CollectionScreen({super.key, required this.customerId});

  final String customerId;

  @override
  ConsumerState<CollectionScreen> createState() => _CollectionScreenState();
}

class _CollectionScreenState extends ConsumerState<CollectionScreen> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formState =
        ref.watch(collectionFormProvider(widget.customerId));
    final controller =
        ref.read(collectionFormProvider(widget.customerId).notifier);

    if (formState.customer == null) {
      return const Scaffold(
        backgroundColor: AppColors.dashboardBg,
        body: Column(
          children: [
            CommonAppBar(title: AppStrings.pigmyDetails, showDownload: true),
            Expanded(child: LoadingWidget()),
          ],
        ),
      );
    }

    final customer = formState.customer!;
    final amountText = formState.amount <= 0
        ? ''
        : formState.amount.toInt().toString();
    if (_amountController.text != amountText &&
        !_amountController.selection.isValid) {
      // keep controller in sync when quick amounts applied
    }

    return Scaffold(
      backgroundColor: AppColors.dashboardBg,
      body: Column(
        children: [
          const CommonAppBar(
            title: AppStrings.pigmyDetails,
            showDownload: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Field(
                      label: AppStrings.transactionNumber,
                      value: '${formState.transactionNumber}',
                    ).animate().fadeIn(duration: 300.ms),
                    const SizedBox(height: 20),
                    _Field(
                      label: AppStrings.pigmyNumber,
                      value: customer.pigmyNumber,
                    ).animate().fadeIn(delay: 40.ms, duration: 300.ms),
                    const SizedBox(height: 20),
                    _Field(
                      label: AppStrings.name,
                      value: customer.customerName,
                    ).animate().fadeIn(delay: 80.ms, duration: 300.ms),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: _Field(
                            label: AppStrings.openDate,
                            value: customer.openDate != null
                                ? AppFormatters.date(customer.openDate!)
                                : '-',
                          ),
                        ),
                        Expanded(
                          child: _Field(
                            label: AppStrings.date,
                            value: AppFormatters.date(DateTime.now()),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 120.ms, duration: 300.ms),
                    const SizedBox(height: 20),
                    _Field(
                      label: AppStrings.previousBalance,
                      value: AppFormatters.currency(customer.openingBalance),
                    ).animate().fadeIn(delay: 160.ms, duration: 300.ms),
                    const SizedBox(height: 16),
                    const Divider(height: 1, color: Color(0xFFEDF0FC)),
                    const SizedBox(height: 16),
                    Text(
                      AppStrings.collectionAmount,
                      style: _labelStyle,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      style: AppTextStyles.bodyLarge.copyWith(
                        fontSize: 20,
                        height: 24 / 20,
                        color: AppColors.textDark,
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: '₹ 0',
                        hintStyle: AppTextStyles.bodyLarge.copyWith(
                          fontSize: 20,
                          height: 24 / 20,
                          color: AppColors.placeholder,
                        ),
                        prefixText:
                            _amountController.text.isEmpty ? null : '₹ ',
                        prefixStyle: AppTextStyles.bodyLarge.copyWith(
                          fontSize: 20,
                          color: AppColors.textDark,
                        ),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.inputBorderEmpty),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.inputBorderEmpty),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColors.inputBorderFilled),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onChanged: (v) {
                        setState(() {});
                        controller.setAmount(double.tryParse(v) ?? 0);
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _QuickChip(
                          label: '₹ 100',
                          onTap: () => _applyQuickAmount(100, controller),
                        ),
                        const SizedBox(width: 12),
                        _QuickChip(
                          label: '₹ 200',
                          onTap: () => _applyQuickAmount(200, controller),
                        ),
                        const SizedBox(width: 12),
                        _QuickChip(
                          label: '₹ 500',
                          onTap: () => _applyQuickAmount(500, controller),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _PaymentModeDropdown(
                      selected: formState.paymentMode,
                      onChanged: controller.setPaymentMode,
                    ),
                    const SizedBox(height: 24),
                    _Field(
                      label: AppStrings.closingBalance,
                      value: AppFormatters.currency(formState.closingBalance),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: CommonButton(
                            label: AppStrings.cancel,
                            isOutlined: true,
                            onPressed: () => context.pop(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: CommonButton(
                            label: AppStrings.save,
                            isLoading: formState.isSaving,
                            isEnabled: formState.amount > 0,
                            onPressed: () => _handleSave(context, controller),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle get _labelStyle => AppTextStyles.bodySmall.copyWith(
        fontWeight: FontWeight.w300,
        fontSize: 12,
        letterSpacing: 0.12,
        height: 16 / 12,
        color: const Color(0xFF404040),
      );

  void _applyQuickAmount(double amount, CollectionFormController controller) {
    controller.addQuickAmount(amount);
    final newAmount =
        ref.read(collectionFormProvider(widget.customerId)).amount;
    setState(() {
      _amountController.text = newAmount.toInt().toString();
    });
  }

  Future<void> _handleSave(
    BuildContext context,
    CollectionFormController controller,
  ) async {
    final success = await controller.save();
    if (success && context.mounted) {
      ref.invalidate(customerSearchProvider);
      ref.invalidate(transactionsProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text(AppStrings.collectionSaved)),
      );
      context.pop();
    }
  }
}

class _Field extends StatelessWidget {
  const _Field({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 12,
            letterSpacing: 0.12,
            height: 16 / 12,
            color: const Color(0xFF404040),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: AppTextStyles.bodyMedium.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 14,
            letterSpacing: 0.14,
            height: 1,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}

class _QuickChip extends StatelessWidget {
  const _QuickChip({required this.label, required this.onTap});

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 61,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE6E7ED)),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: const Color(0xFF535A7B),
          ),
        ),
      ),
    );
  }
}

class _PaymentModeDropdown extends StatelessWidget {
  const _PaymentModeDropdown({
    required this.selected,
    required this.onChanged,
  });

  final PaymentMode selected;
  final ValueChanged<PaymentMode> onChanged;

  String get _label => switch (selected) {
        PaymentMode.cash => AppStrings.cash,
        PaymentMode.cheque => AppStrings.cheque,
        PaymentMode.upi => AppStrings.upi,
      };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.paymentMode,
          style: AppTextStyles.bodySmall.copyWith(
            fontWeight: FontWeight.w300,
            fontSize: 12,
            letterSpacing: 0.12,
            height: 16 / 12,
            color: const Color(0xFF404040),
          ),
        ),
        PopupMenuButton<PaymentMode>(
          onSelected: onChanged,
          offset: const Offset(0, 40),
          itemBuilder: (context) => PaymentMode.values
              .map(
                (mode) => PopupMenuItem(
                  value: mode,
                  child: Text(switch (mode) {
                    PaymentMode.cash => AppStrings.cash,
                    PaymentMode.cheque => AppStrings.cheque,
                    PaymentMode.upi => AppStrings.upi,
                  }),
                ),
              )
              .toList(),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 6, bottom: 12, right: 16),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.inputBorderEmpty),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    _label,
                    style: AppTextStyles.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 0.14,
                    ),
                  ),
                ),
                Transform.rotate(
                  angle: 1.5708,
                  child: SvgPicture.asset(
                    AppAssets.chevronRight,
                    width: 16,
                    height: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
