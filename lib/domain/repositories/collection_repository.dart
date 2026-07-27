import '../../core/utils/result.dart';
import '../entities/collection_entity.dart';

abstract class CollectionRepository {
  Future<Result<List<CollectionEntity>>> getCollections({
    required CollectionType type,
    DateTime? fromDate,
    DateTime? toDate,
  });

  Future<Result<CollectionEntity>> createCollection(CollectionEntity collection);

  Future<Result<CollectionEntity>> getCollectionById(String id);

  Future<Result<List<CollectionEntity>>> getPendingSyncCollections();
}
