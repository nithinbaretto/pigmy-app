import 'package:flutter/material.dart';

/// Sync widgets placeholder.
class SyncStatusIndicator extends StatelessWidget {
  const SyncStatusIndicator({super.key, required this.isSyncing});

  final bool isSyncing;

  @override
  Widget build(BuildContext context) {
    return isSyncing
        ? const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : const Icon(Icons.cloud_done, size: 16);
  }
}
