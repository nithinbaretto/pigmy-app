import 'package:isar/isar.dart';

import '../../../core/services/isar_service.dart';
import '../../../domain/entities/collection_entity.dart';
import '../../models/collection_model.dart';

abstract class CollectionLocalDataSource {
  Future<List<CollectionModel>> getCollections({
    required CollectionType type,
    DateTime? fromDate,
    DateTime? toDate,
  });

  Future<CollectionModel?> getByServerId(String serverId);

  Future<int> save(CollectionModel model);

  Future<void> markSynced(int localId, String serverId);

  Future<List<CollectionModel>> getPendingSync();
}

class CollectionLocalDataSourceImpl implements CollectionLocalDataSource {
  CollectionLocalDataSourceImpl(this._isarService);

  final IsarService _isarService;

  @override
  Future<List<CollectionModel>> getCollections({
    required CollectionType type,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    final isar = _isarService.instance;
    var query = isar.collectionModels.filter().typeCodeEqualTo(type.code);

    if (fromDate != null) {
      query = query.collectedAtGreaterThan(fromDate, include: true);
    }
    if (toDate != null) {
      query = query.collectedAtLessThan(toDate, include: true);
    }

    return query.sortByCollectedAtDesc().findAll();
  }

  @override
  Future<CollectionModel?> getByServerId(String serverId) async {
    return _isarService.instance.collectionModels
        .filter()
        .serverIdEqualTo(serverId)
        .findFirst();
  }

  @override
  Future<int> save(CollectionModel model) async {
    return _isarService.instance.writeTxn(() async {
      return _isarService.instance.collectionModels.put(model);
    });
  }

  @override
  Future<void> markSynced(int localId, String serverId) async {
    await _isarService.instance.writeTxn(() async {
      final model = await _isarService.instance.collectionModels.get(localId);
      if (model != null) {
        model.isSynced = true;
        model.serverId = serverId;
        await _isarService.instance.collectionModels.put(model);
      }
    });
  }

  @override
  Future<List<CollectionModel>> getPendingSync() async {
    return _isarService.instance.collectionModels
        .filter()
        .isSyncedEqualTo(false)
        .findAll();
  }
}
