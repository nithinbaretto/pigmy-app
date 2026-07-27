import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/providers.dart';
import '../service/sync_service.dart';

class SyncControllerState {
  const SyncControllerState({
    this.status = SyncStatus.idle,
    this.lastError,
    this.autoSyncEnabled = true,
  });

  final SyncStatus status;
  final String? lastError;
  final bool autoSyncEnabled;

  SyncControllerState copyWith({
    SyncStatus? status,
    String? lastError,
    bool? autoSyncEnabled,
  }) {
    return SyncControllerState(
      status: status ?? this.status,
      lastError: lastError ?? this.lastError,
      autoSyncEnabled: autoSyncEnabled ?? this.autoSyncEnabled,
    );
  }
}

final syncControllerProvider =
    StateNotifierProvider<SyncController, SyncControllerState>((ref) {
  return SyncController(ref.watch(syncServiceProvider));
});

class SyncController extends StateNotifier<SyncControllerState> {
  SyncController(this._syncService) : super(const SyncControllerState()) {
    _syncService.startPeriodicSync();
  }

  final SyncService _syncService;

  Future<void> syncNow() async {
    state = state.copyWith(status: SyncStatus.syncing);
    final result = await _syncService.syncNow();
    result.when(
      success: (_) => state = state.copyWith(
        status: SyncStatus.success,
        lastError: null,
      ),
      onFailure: (f) => state = state.copyWith(
        status: SyncStatus.error,
        lastError: f.message,
      ),
    );
  }

  void toggleAutoSync(bool enabled) {
    state = state.copyWith(autoSyncEnabled: enabled);
    if (enabled) {
      _syncService.startPeriodicSync();
    } else {
      _syncService.stopPeriodicSync();
    }
  }

  @override
  void dispose() {
    _syncService.dispose();
    super.dispose();
  }
}
