import 'package:equatable/equatable.dart';

enum SyncAction {
  create,
  update,
  delete,
}

enum SyncEntityType {
  collection,
  transaction,
}

class SyncQueueEntity extends Equatable {
  const SyncQueueEntity({
    required this.id,
    required this.entityType,
    required this.entityId,
    required this.action,
    required this.payload,
    required this.createdAt,
    this.retryCount = 0,
    this.lastError,
  });

  final int id;
  final SyncEntityType entityType;
  final String entityId;
  final SyncAction action;
  final Map<String, dynamic> payload;
  final DateTime createdAt;
  final int retryCount;
  final String? lastError;

  @override
  List<Object?> get props => [
        id,
        entityType,
        entityId,
        action,
        payload,
        createdAt,
        retryCount,
        lastError,
      ];
}
