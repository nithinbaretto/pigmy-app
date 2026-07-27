import 'package:isar/isar.dart';

import '../../domain/entities/sync_queue_entity.dart';

part 'sync_queue_model.g.dart';

@collection
class SyncQueueModel {
  Id id = Isar.autoIncrement;

  @Enumerated(EnumType.name)
  late SyncEntityType entityType;

  late String entityId;

  @Enumerated(EnumType.name)
  late SyncAction action;

  late String payloadJson;
  late DateTime createdAt;
  late int retryCount;
  String? lastError;

  SyncQueueEntity toEntity() {
    return SyncQueueEntity(
      id: id,
      entityType: entityType,
      entityId: entityId,
      action: action,
      payload: {},
      createdAt: createdAt,
      retryCount: retryCount,
      lastError: lastError,
    );
  }
}
