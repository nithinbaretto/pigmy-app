import '../../core/constants/storage_keys.dart';
import '../../core/services/secure_storage_service.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required SecureStorageService secureStorage,
  })  : _remoteDataSource = remoteDataSource,
        _secureStorage = secureStorage;

  final AuthRemoteDataSource _remoteDataSource;
  final SecureStorageService _secureStorage;

  @override
  Future<Result<UserEntity>> login({
    required String username,
    required String password,
  }) async {
    try {
      final userModel = await _remoteDataSource.login(
        username: username,
        password: password,
      );

      if (userModel.accessToken != null && userModel.refreshToken != null) {
        await _secureStorage.saveTokens(
          accessToken: userModel.accessToken!,
          refreshToken: userModel.refreshToken!,
        );
      }

      await _secureStorage.write(StorageKeys.userId, userModel.id);
      await _secureStorage.write(StorageKeys.userName, userModel.name);

      return Success(userModel.toEntity());
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await _remoteDataSource.logout();
      await _secureStorage.clearSession();
      return const Success(null);
    } catch (e) {
      await _secureStorage.clearSession();
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  @override
  Future<Result<UserEntity?>> getCurrentUser() async {
    try {
      final userId = await _secureStorage.read(StorageKeys.userId);
      final userName = await _secureStorage.read(StorageKeys.userName);

      if (userId == null || userName == null) {
        return const Success(null);
      }

      return Success(UserEntity(id: userId, name: userName, email: ''));
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  @override
  Future<bool> isAuthenticated() => _secureStorage.isLoggedIn();
}
