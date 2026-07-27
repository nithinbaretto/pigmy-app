import '../../core/utils/result.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase {
  LogoutUseCase(this._repository);

  final AuthRepository _repository;

  Future<Result<void>> call() => _repository.logout();
}
