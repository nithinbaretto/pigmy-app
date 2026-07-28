import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../transactions/model/transaction.dart';
import '../model/customer.dart';
import '../repository/customer_repository.dart';
import '../../transactions/repository/transaction_repository.dart';
import '../../../shared/providers/repository_providers.dart';

class CollectionFormState {
  const CollectionFormState({
    this.customer,
    this.amount = 0,
    this.paymentMode = PaymentMode.cash,
    this.isSaving = false,
    this.transactionNumber = 12,
  });

  final Customer? customer;
  final double amount;
  final PaymentMode paymentMode;
  final bool isSaving;
  final int transactionNumber;

  double get closingBalance => (customer?.openingBalance ?? 0) + amount;

  CollectionFormState copyWith({
    Customer? customer,
    double? amount,
    PaymentMode? paymentMode,
    bool? isSaving,
    int? transactionNumber,
  }) {
    return CollectionFormState(
      customer: customer ?? this.customer,
      amount: amount ?? this.amount,
      paymentMode: paymentMode ?? this.paymentMode,
      isSaving: isSaving ?? this.isSaving,
      transactionNumber: transactionNumber ?? this.transactionNumber,
    );
  }
}

final collectionFormProvider = StateNotifierProvider.family<
    CollectionFormController, CollectionFormState, String>(
  (ref, customerId) {
    return CollectionFormController(
      customerId,
      ref.watch(customerRepositoryProvider),
      ref.watch(transactionRepositoryProvider),
    );
  },
);

class CollectionFormController extends StateNotifier<CollectionFormState> {
  CollectionFormController(
    this._customerId,
    this._customerRepo,
    this._transactionRepo,
  ) : super(const CollectionFormState()) {
    _loadCustomer();
  }

  final String _customerId;
  final CustomerRepository _customerRepo;
  final TransactionRepository _transactionRepo;

  Future<void> _loadCustomer() async {
    final customer = await _customerRepo.getCustomerById(_customerId);
    state = state.copyWith(customer: customer);
  }

  void setAmount(double amount) => state = state.copyWith(amount: amount);

  void addQuickAmount(double value) =>
      state = state.copyWith(amount: state.amount + value);

  void setPaymentMode(PaymentMode mode) =>
      state = state.copyWith(paymentMode: mode);

  Future<bool> save() async {
    if (state.customer == null) return false;
    state = state.copyWith(isSaving: true);

    await _customerRepo.updateCustomerBalance(
      _customerId,
      state.closingBalance,
    );

    await _transactionRepo.addTransaction(
      Transaction(
        id: const Uuid().v4(),
        customerId: _customerId,
        customerName: state.customer!.customerName,
        pigmyNumber: state.customer!.pigmyNumber,
        amount: state.amount,
        date: DateTime.now(),
        status: TransactionStatus.completed,
        paymentMode: state.paymentMode,
      ),
    );

    state = state.copyWith(isSaving: false);
    return true;
  }
}
