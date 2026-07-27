import '../../core/utils/result.dart';
import '../entities/collection_entity.dart';
import '../repositories/collection_repository.dart';

class GetCollectionsUseCase {
  GetCollectionsUseCase(this._repository);

  final CollectionRepository _repository;

  Future<Result<List<CollectionEntity>>> call({
    required CollectionType type,
    DateTime? fromDate,
    DateTime? toDate,
  }) {
    return _repository.getCollections(
      type: type,
      fromDate: fromDate,
      toDate: toDate,
    );
  }
}
