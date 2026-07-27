import '../../../domain/entities/collection_entity.dart';
import '../../../domain/repositories/collection_repository.dart';

/// Feature-level repository wrapper — delegates to domain repository.
class CollectionFeatureRepository {
  CollectionFeatureRepository(this._repository);

  final CollectionRepository _repository;

  Future<List<CollectionEntity>> getCollections(CollectionType type) async {
    final result = await _repository.getCollections(type: type);
    return result.when(
      success: (data) => data,
      onFailure: (f) => throw Exception(f.message),
    );
  }

  Future<CollectionEntity> createCollection(CollectionEntity entity) async {
    final result = await _repository.createCollection(entity);
    return result.when(
      success: (data) => data,
      onFailure: (f) => throw Exception(f.message),
    );
  }
}
