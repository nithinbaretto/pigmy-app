/// Sync model placeholder.
class SyncStats {
  const SyncStats({this.pendingCount = 0, this.lastSyncAt});

  final int pendingCount;
  final DateTime? lastSyncAt;
}
