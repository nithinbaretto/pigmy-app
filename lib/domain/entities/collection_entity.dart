import 'package:equatable/equatable.dart';

/// Generic collection types supported by the application.
enum CollectionType {
  pigmy('PIGMY', 'Pigmy'),
  loan('LOAN', 'Loan'),
  rd('RD', 'Recurring Deposit'),
  sb('SB', 'Savings Bank');

  const CollectionType(this.code, this.label);

  final String code;
  final String label;

  static CollectionType fromCode(String code) {
    return CollectionType.values.firstWhere(
      (type) => type.code == code.toUpperCase(),
      orElse: () => CollectionType.pigmy,
    );
  }
}

class CollectionEntity extends Equatable {
  const CollectionEntity({
    required this.id,
    required this.type,
    required this.accountNumber,
    required this.customerName,
    required this.customerMobile,
    required this.amount,
    required this.collectedAt,
    this.agentId,
    this.remarks,
    this.isSynced = false,
    this.localId,
  });

  final String id;
  final CollectionType type;
  final String accountNumber;
  final String customerName;
  final String customerMobile;
  final double amount;
  final DateTime collectedAt;
  final String? agentId;
  final String? remarks;
  final bool isSynced;
  final int? localId;

  CollectionEntity copyWith({
    String? id,
    CollectionType? type,
    String? accountNumber,
    String? customerName,
    String? customerMobile,
    double? amount,
    DateTime? collectedAt,
    String? agentId,
    String? remarks,
    bool? isSynced,
    int? localId,
  }) {
    return CollectionEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      accountNumber: accountNumber ?? this.accountNumber,
      customerName: customerName ?? this.customerName,
      customerMobile: customerMobile ?? this.customerMobile,
      amount: amount ?? this.amount,
      collectedAt: collectedAt ?? this.collectedAt,
      agentId: agentId ?? this.agentId,
      remarks: remarks ?? this.remarks,
      isSynced: isSynced ?? this.isSynced,
      localId: localId ?? this.localId,
    );
  }

  @override
  List<Object?> get props => [
        id,
        type,
        accountNumber,
        customerName,
        customerMobile,
        amount,
        collectedAt,
        agentId,
        remarks,
        isSynced,
        localId,
      ];
}
