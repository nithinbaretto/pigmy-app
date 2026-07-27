import '../../../domain/entities/collection_entity.dart';

class CollectionFormState {
  const CollectionFormState({
    this.accountNumber = '',
    this.customerName = '',
    this.customerMobile = '',
    this.amount = '',
    this.remarks = '',
    this.isSubmitting = false,
    this.error,
  });

  final String accountNumber;
  final String customerName;
  final String customerMobile;
  final String amount;
  final String remarks;
  final bool isSubmitting;
  final String? error;

  CollectionFormState copyWith({
    String? accountNumber,
    String? customerName,
    String? customerMobile,
    String? amount,
    String? remarks,
    bool? isSubmitting,
    String? error,
  }) {
    return CollectionFormState(
      accountNumber: accountNumber ?? this.accountNumber,
      customerName: customerName ?? this.customerName,
      customerMobile: customerMobile ?? this.customerMobile,
      amount: amount ?? this.amount,
      remarks: remarks ?? this.remarks,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error,
    );
  }

  CollectionEntity toEntity(CollectionType type) {
    return CollectionEntity(
      id: '',
      type: type,
      accountNumber: accountNumber.trim(),
      customerName: customerName.trim(),
      customerMobile: customerMobile.trim(),
      amount: double.parse(amount),
      collectedAt: DateTime.now(),
      remarks: remarks.trim().isEmpty ? null : remarks.trim(),
    );
  }
}
