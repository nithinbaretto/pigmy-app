import '../../../domain/entities/collection_entity.dart';

/// Configuration for each collection type — drives labels, validation, and UI.
class CollectionConfig {
  const CollectionConfig({
    required this.type,
    required this.title,
    required this.accountLabel,
    required this.amountLabel,
    this.showInstallmentField = false,
    this.showDueDateField = false,
  });

  final CollectionType type;
  final String title;
  final String accountLabel;
  final String amountLabel;
  final bool showInstallmentField;
  final bool showDueDateField;

  static CollectionConfig forType(CollectionType type) {
    return switch (type) {
      CollectionType.pigmy => const CollectionConfig(
          type: CollectionType.pigmy,
          title: 'Pigmy Collection',
          accountLabel: 'Pigmy Account No.',
          amountLabel: 'Collection Amount',
        ),
      CollectionType.loan => const CollectionConfig(
          type: CollectionType.loan,
          title: 'Loan Collection',
          accountLabel: 'Loan Account No.',
          amountLabel: 'EMI Amount',
          showInstallmentField: true,
          showDueDateField: true,
        ),
      CollectionType.rd => const CollectionConfig(
          type: CollectionType.rd,
          title: 'RD Collection',
          accountLabel: 'RD Account No.',
          amountLabel: 'Installment Amount',
          showInstallmentField: true,
        ),
      CollectionType.sb => const CollectionConfig(
          type: CollectionType.sb,
          title: 'SB Collection',
          accountLabel: 'SB Account No.',
          amountLabel: 'Deposit Amount',
        ),
    };
  }
}
