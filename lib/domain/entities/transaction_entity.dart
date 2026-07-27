import 'package:equatable/equatable.dart';

import 'collection_entity.dart';

class TransactionEntity extends Equatable {
  const TransactionEntity({
    required this.id,
    required this.collectionType,
    required this.accountNumber,
    required this.customerName,
    required this.amount,
    required this.transactionDate,
    this.referenceNumber,
    this.status = TransactionStatus.completed,
    this.isSynced = false,
    this.localId,
  });

  final String id;
  final CollectionType collectionType;
  final String accountNumber;
  final String customerName;
  final double amount;
  final DateTime transactionDate;
  final String? referenceNumber;
  final TransactionStatus status;
  final bool isSynced;
  final int? localId;

  @override
  List<Object?> get props => [
        id,
        collectionType,
        accountNumber,
        customerName,
        amount,
        transactionDate,
        referenceNumber,
        status,
        isSynced,
        localId,
      ];
}

enum TransactionStatus {
  pending,
  completed,
  failed,
  cancelled,
}
