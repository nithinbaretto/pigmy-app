import 'package:isar/isar.dart';

import '../../domain/entities/collection_entity.dart';

part 'collection_model.g.dart';

@collection
class CollectionModel {
  Id id = Isar.autoIncrement;

  @Index()
  late String serverId;

  @Index()
  late String typeCode;

  late String accountNumber;
  late String customerName;
  late String customerMobile;
  late double amount;
  late DateTime collectedAt;
  String? agentId;
  String? remarks;

  @Index()
  late bool isSynced;

  CollectionEntity toEntity() {
    return CollectionEntity(
      id: serverId,
      type: CollectionType.fromCode(typeCode),
      accountNumber: accountNumber,
      customerName: customerName,
      customerMobile: customerMobile,
      amount: amount,
      collectedAt: collectedAt,
      agentId: agentId,
      remarks: remarks,
      isSynced: isSynced,
      localId: id,
    );
  }

  static CollectionModel fromEntity(CollectionEntity entity) {
    return CollectionModel()
      ..serverId = entity.id
      ..typeCode = entity.type.code
      ..accountNumber = entity.accountNumber
      ..customerName = entity.customerName
      ..customerMobile = entity.customerMobile
      ..amount = entity.amount
      ..collectedAt = entity.collectedAt
      ..agentId = entity.agentId
      ..remarks = entity.remarks
      ..isSynced = entity.isSynced;
  }

  Map<String, dynamic> toJson() => {
        'id': serverId,
        'type': typeCode,
        'account_number': accountNumber,
        'customer_name': customerName,
        'customer_mobile': customerMobile,
        'amount': amount,
        'collected_at': collectedAt.toIso8601String(),
        'agent_id': agentId,
        'remarks': remarks,
      };

  static CollectionModel fromJson(Map<String, dynamic> json) {
    return CollectionModel()
      ..serverId = json['id'] as String? ?? ''
      ..typeCode = json['type'] as String? ?? CollectionType.pigmy.code
      ..accountNumber = json['account_number'] as String? ?? ''
      ..customerName = json['customer_name'] as String? ?? ''
      ..customerMobile = json['customer_mobile'] as String? ?? ''
      ..amount = (json['amount'] as num?)?.toDouble() ?? 0
      ..collectedAt = DateTime.tryParse(json['collected_at'] as String? ?? '') ??
          DateTime.now()
      ..agentId = json['agent_id'] as String?
      ..remarks = json['remarks'] as String?
      ..isSynced = true;
  }
}
