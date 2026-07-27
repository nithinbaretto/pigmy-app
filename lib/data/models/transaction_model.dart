import 'package:isar/isar.dart';

import '../../domain/entities/collection_entity.dart';
import '../../domain/entities/transaction_entity.dart';

part 'transaction_model.g.dart';

@collection
class TransactionModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String serverId;

  @Index()
  late String collectionTypeCode;

  late String accountNumber;
  late String customerName;
  late double amount;
  late DateTime transactionDate;
  String? referenceNumber;

  @Enumerated(EnumType.name)
  late TransactionStatus status;

  @Index()
  late bool isSynced;

  TransactionEntity toEntity() {
    return TransactionEntity(
      id: serverId,
      collectionType: CollectionType.fromCode(collectionTypeCode),
      accountNumber: accountNumber,
      customerName: customerName,
      amount: amount,
      transactionDate: transactionDate,
      referenceNumber: referenceNumber,
      status: status,
      isSynced: isSynced,
      localId: id,
    );
  }

  static TransactionModel fromEntity(TransactionEntity entity) {
    return TransactionModel()
      ..serverId = entity.id
      ..collectionTypeCode = entity.collectionType.code
      ..accountNumber = entity.accountNumber
      ..customerName = entity.customerName
      ..amount = entity.amount
      ..transactionDate = entity.transactionDate
      ..referenceNumber = entity.referenceNumber
      ..status = entity.status
      ..isSynced = entity.isSynced;
  }

  Map<String, dynamic> toJson() => {
        'id': serverId,
        'collection_type': collectionTypeCode,
        'account_number': accountNumber,
        'customer_name': customerName,
        'amount': amount,
        'transaction_date': transactionDate.toIso8601String(),
        'reference_number': referenceNumber,
        'status': status.name,
      };

  static TransactionModel fromJson(Map<String, dynamic> json) {
    return TransactionModel()
      ..serverId = json['id'] as String? ?? ''
      ..collectionTypeCode =
          json['collection_type'] as String? ?? CollectionType.pigmy.code
      ..accountNumber = json['account_number'] as String? ?? ''
      ..customerName = json['customer_name'] as String? ?? ''
      ..amount = (json['amount'] as num?)?.toDouble() ?? 0
      ..transactionDate =
          DateTime.tryParse(json['transaction_date'] as String? ?? '') ??
              DateTime.now()
      ..referenceNumber = json['reference_number'] as String?
      ..status = TransactionStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => TransactionStatus.completed,
      )
      ..isSynced = true;
  }
}
