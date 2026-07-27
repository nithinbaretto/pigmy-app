import 'dart:convert';

import 'package:isar/isar.dart';

import '../../../core/services/isar_service.dart';
import '../../models/sync_queue_model.dart';

abstract class SyncQueueLocalDataSource {
  Future<int> enqueue(SyncQueueModel item);

  Future<List<SyncQueueModel>> getPending();

  Future<void> delete(int id);

  Future<void> incrementRetry(int id, String error);
}

class SyncQueueLocalDataSourceImpl implements SyncQueueLocalDataSource {
  SyncQueueLocalDataSourceImpl(this._isarService);

  final IsarService _isarService;

  @override
  Future<int> enqueue(SyncQueueModel item) async {
    return _isarService.instance.writeTxn(() async {
      return _isarService.instance.syncQueueModels.put(item);
    });
  }

  @override
  Future<List<SyncQueueModel>> getPending() async {
    final items = await _isarService.instance.syncQueueModels
        .where()
        .anyId()
        .findAll();
    items.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return items;
  }

  @override
  Future<void> delete(int id) async {
    await _isarService.instance.writeTxn(() async {
      await _isarService.instance.syncQueueModels.delete(id);
    });
  }

  @override
  Future<void> incrementRetry(int id, String error) async {
    await _isarService.instance.writeTxn(() async {
      final item = await _isarService.instance.syncQueueModels.get(id);
      if (item != null) {
        item.retryCount += 1;
        item.lastError = error;
        await _isarService.instance.syncQueueModels.put(item);
      }
    });
  }

  static String encodePayload(Map<String, dynamic> payload) {
    return jsonEncode(payload);
  }

  static Map<String, dynamic> decodePayload(String payloadJson) {
    return jsonDecode(payloadJson) as Map<String, dynamic>;
  }
}
