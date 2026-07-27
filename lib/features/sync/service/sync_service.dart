import 'dart:async';

import '../../../core/constants/app_constants.dart';
import '../../../core/network/network_info.dart';
import '../../../core/utils/logger.dart';
import '../../../core/utils/result.dart';
import '../../../domain/repositories/collection_repository.dart';
import '../../../domain/repositories/sync_repository.dart';

enum SyncStatus { idle, syncing, success, error }

class SyncService {
  SyncService({
    required SyncRepository syncRepository,
    required NetworkInfo networkInfo,
    required CollectionRepository collectionRepository,
  })  : _syncRepository = syncRepository,
        _networkInfo = networkInfo,
        _collectionRepository = collectionRepository;

  final SyncRepository _syncRepository;
  final NetworkInfo _networkInfo;
  final CollectionRepository _collectionRepository;

  SyncStatus _status = SyncStatus.idle;
  String? _lastError;
  Timer? _periodicTimer;

  SyncStatus get status => _status;
  String? get lastError => _lastError;

  void startPeriodicSync() {
    _periodicTimer?.cancel();
    _periodicTimer = Timer.periodic(AppConstants.syncInterval, (_) {
      syncNow();
    });
    AppLogger.info('Periodic sync started');
  }

  void stopPeriodicSync() {
    _periodicTimer?.cancel();
    _periodicTimer = null;
    AppLogger.info('Periodic sync stopped');
  }

  Future<Result<void>> syncNow() async {
    if (!await _networkInfo.isConnected) {
      _status = SyncStatus.error;
      _lastError = 'No internet connection';
      return const Error(Failure(message: 'No internet connection'));
    }

    _status = SyncStatus.syncing;
    AppLogger.info('Sync started');

    try {
      // Push pending collections first
      final pendingResult = await _collectionRepository.getPendingSyncCollections();
      if (pendingResult.isSuccess) {
        AppLogger.info(
          'Found ${pendingResult.dataOrNull?.length ?? 0} pending collections',
        );
      }

      final result = await _syncRepository.syncAll();

      result.when(
        success: (_) {
          _status = SyncStatus.success;
          _lastError = null;
          AppLogger.info('Sync completed successfully');
        },
        onFailure: (failure) {
          _status = SyncStatus.error;
          _lastError = failure.message;
          AppLogger.error('Sync failed', failure.exception);
        },
      );

      return result;
    } catch (e) {
      _status = SyncStatus.error;
      _lastError = e.toString();
      return Error(Failure(message: e.toString(), exception: e));
    }
  }

  void dispose() {
    stopPeriodicSync();
  }
}
