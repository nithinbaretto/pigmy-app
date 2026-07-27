import '../../core/network/network_info.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/collection_entity.dart';
import '../../domain/entities/transaction_entity.dart';
import '../../domain/repositories/transaction_repository.dart';
import '../datasource/local/transaction_local_datasource.dart';
import '../datasource/remote/transaction_remote_datasource.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  TransactionRepositoryImpl({
    required TransactionLocalDataSource localDataSource,
    required TransactionRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  final TransactionLocalDataSource _localDataSource;
  final TransactionRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Result<List<TransactionEntity>>> getTransactions({
    CollectionType? type,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        try {
          final remote = await _remoteDataSource.getTransactions(
            type: type,
            fromDate: fromDate,
            toDate: toDate,
          );
          for (final model in remote) {
            await _localDataSource.save(model);
          }
        } catch (_) {}
      }

      final local = await _localDataSource.getTransactions(
        type: type,
        fromDate: fromDate,
        toDate: toDate,
      );
      return Success(local.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  @override
  Future<Result<TransactionEntity>> getTransactionById(String id) async {
    try {
      final local = await _localDataSource.getByServerId(id);
      if (local != null) return Success(local.toEntity());

      if (await _networkInfo.isConnected) {
        final remote = await _remoteDataSource.getTransactionById(id);
        await _localDataSource.save(remote);
        return Success(remote.toEntity());
      }

      return const Error(Failure(message: 'Transaction not found'));
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }
}
