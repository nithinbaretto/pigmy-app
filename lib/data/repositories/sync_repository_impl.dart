import '../../core/network/network_info.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/sync_queue_entity.dart';
import '../../domain/repositories/sync_repository.dart';
import '../datasource/local/sync_queue_local_datasource.dart';
import '../datasource/remote/sync_remote_datasource.dart';
import '../models/sync_queue_model.dart';

class SyncRepositoryImpl implements SyncRepository {
  SyncRepositoryImpl({
    required SyncQueueLocalDataSource localDataSource,
    required SyncRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  final SyncQueueLocalDataSource _localDataSource;
  final SyncRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Result<void>> enqueue(SyncQueueEntity item) async {
    try {
      final model = SyncQueueModel()
        ..entityType = item.entityType
        ..entityId = item.entityId
        ..action = item.action
        ..payloadJson =
            SyncQueueLocalDataSourceImpl.encodePayload(item.payload)
        ..createdAt = item.createdAt
        ..retryCount = item.retryCount
        ..lastError = item.lastError;

      await _localDataSource.enqueue(model);
      return const Success(null);
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  @override
  Future<Result<List<SyncQueueEntity>>> getPendingItems() async {
    try {
      final items = await _localDataSource.getPending();
      return Success(items.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  @override
  Future<Result<void>> markSynced(int queueId) async {
    try {
      await _localDataSource.delete(queueId);
      return const Success(null);
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  @override
  Future<Result<void>> syncAll() async {
    if (!await _networkInfo.isConnected) {
      return const Error(Failure(message: 'No internet connection'));
    }

    try {
      final pending = await _localDataSource.getPending();
      if (pending.isEmpty) return const Success(null);

      final changes = pending
          .map(
            (item) => {
              'entity_type': item.entityType.name,
              'entity_id': item.entityId,
              'action': item.action.name,
              'payload': SyncQueueLocalDataSourceImpl.decodePayload(
                item.payloadJson,
              ),
            },
          )
          .toList();

      await _remoteDataSource.pushChanges(changes);

      for (final item in pending) {
        await _localDataSource.delete(item.id);
      }

      return const Success(null);
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }
}
