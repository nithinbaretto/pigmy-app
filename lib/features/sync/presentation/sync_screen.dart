import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../controller/sync_controller.dart';
import '../service/sync_service.dart';

class SyncScreen extends ConsumerWidget {
  const SyncScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(syncControllerProvider);
    final controller = ref.read(syncControllerProvider.notifier);

    return AppScaffold(
      title: 'Sync',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: ListTile(
                leading: Icon(_statusIcon(state.status)),
                title: Text('Status: ${_statusLabel(state.status)}'),
                subtitle: state.lastError != null ? Text(state.lastError!) : null,
              ),
            ),
            const SizedBox(height: 16),
            AppButton(
              label: 'Sync Now',
              isLoading: state.status == SyncStatus.syncing,
              onPressed: controller.syncNow,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Auto Sync'),
              subtitle: const Text('Sync every 5 minutes when online'),
              value: state.autoSyncEnabled,
              onChanged: controller.toggleAutoSync,
            ),
          ],
        ),
      ),
    );
  }

  IconData _statusIcon(SyncStatus status) => switch (status) {
        SyncStatus.idle => Icons.cloud_queue,
        SyncStatus.syncing => Icons.sync,
        SyncStatus.success => Icons.cloud_done,
        SyncStatus.error => Icons.cloud_off,
      };

  String _statusLabel(SyncStatus status) => switch (status) {
        SyncStatus.idle => 'Idle',
        SyncStatus.syncing => 'Syncing...',
        SyncStatus.success => 'Success',
        SyncStatus.error => 'Error',
      };
}
