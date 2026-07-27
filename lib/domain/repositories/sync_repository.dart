import '../../core/utils/result.dart';
import '../entities/sync_queue_entity.dart';

abstract class SyncRepository {
  Future<Result<void>> enqueue(SyncQueueEntity item);

  Future<Result<List<SyncQueueEntity>>> getPendingItems();

  Future<Result<void>> markSynced(int queueId);

  Future<Result<void>> syncAll();
}
