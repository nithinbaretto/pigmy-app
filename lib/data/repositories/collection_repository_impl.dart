import 'package:uuid/uuid.dart';

import '../../core/network/network_info.dart';
import '../../core/utils/result.dart';
import '../../domain/entities/collection_entity.dart';
import '../../domain/repositories/collection_repository.dart';
import '../datasource/local/collection_local_datasource.dart';
import '../datasource/remote/collection_remote_datasource.dart';
import '../models/collection_model.dart';

class CollectionRepositoryImpl implements CollectionRepository {
  CollectionRepositoryImpl({
    required CollectionLocalDataSource localDataSource,
    required CollectionRemoteDataSource remoteDataSource,
    required NetworkInfo networkInfo,
  })  : _localDataSource = localDataSource,
        _remoteDataSource = remoteDataSource,
        _networkInfo = networkInfo;

  final CollectionLocalDataSource _localDataSource;
  final CollectionRemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;
  final _uuid = const Uuid();

  @override
  Future<Result<List<CollectionEntity>>> getCollections({
    required CollectionType type,
    DateTime? fromDate,
    DateTime? toDate,
  }) async {
    try {
      if (await _networkInfo.isConnected) {
        try {
          final remote = await _remoteDataSource.getCollections(
            type: type,
            fromDate: fromDate,
            toDate: toDate,
          );
          for (final model in remote) {
            await _localDataSource.save(model);
          }
        } catch (_) {
          // Fall back to local cache on remote failure
        }
      }

      final local = await _localDataSource.getCollections(
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
  Future<Result<CollectionEntity>> createCollection(
    CollectionEntity collection,
  ) async {
    try {
      final localModel = CollectionModel.fromEntity(
        collection.copyWith(id: collection.id.isEmpty ? _uuid.v4() : collection.id),
      );
      localModel.isSynced = false;
      final localId = await _localDataSource.save(localModel);

      if (await _networkInfo.isConnected) {
        try {
          final remote = await _remoteDataSource.createCollection(localModel);
          await _localDataSource.markSynced(localId, remote.serverId);
          return Success(remote.toEntity().copyWith(localId: localId));
        } catch (_) {
          // Saved locally; sync service will push later
        }
      }

      return Success(
        localModel.toEntity().copyWith(localId: localId, isSynced: false),
      );
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  @override
  Future<Result<CollectionEntity>> getCollectionById(String id) async {
    try {
      final local = await _localDataSource.getByServerId(id);
      if (local != null) {
        return Success(local.toEntity());
      }

      if (await _networkInfo.isConnected) {
        final remote = await _remoteDataSource.getCollectionById(id);
        await _localDataSource.save(remote);
        return Success(remote.toEntity());
      }

      return const Error(Failure(message: 'Collection not found'));
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  @override
  Future<Result<List<CollectionEntity>>> getPendingSyncCollections() async {
    try {
      final pending = await _localDataSource.getPendingSync();
      return Success(pending.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Error(Failure(message: e.toString(), exception: e));
    }
  }
}
