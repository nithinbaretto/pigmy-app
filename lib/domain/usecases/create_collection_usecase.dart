import '../../core/utils/result.dart';
import '../entities/collection_entity.dart';
import '../repositories/collection_repository.dart';

class CreateCollectionUseCase {
  CreateCollectionUseCase(this._repository);

  final CollectionRepository _repository;

  Future<Result<CollectionEntity>> call(CollectionEntity collection) {
    return _repository.createCollection(collection);
  }
}
