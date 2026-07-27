import '../../core/utils/result.dart';
import '../repositories/sync_repository.dart';

class SyncPendingUseCase {
  SyncPendingUseCase(this._repository);

  final SyncRepository _repository;

  Future<Result<void>> call() => _repository.syncAll();
}
