import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/app_button.dart';
import '../../../shared/widgets/app_scaffold.dart';
import '../controller/printer_controller.dart';

class PrinterScreen extends ConsumerWidget {
  const PrinterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(printerControllerProvider);
    final controller = ref.read(printerControllerProvider.notifier);

    return AppScaffold(
      title: 'Printer Setup',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (state.connectedDeviceName != null)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.print, color: Colors.green),
                  title: Text('Connected: ${state.connectedDeviceName}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.link_off),
                    onPressed: controller.disconnect,
                  ),
                ),
              ),
            const SizedBox(height: 16),
            AppButton(
              label: state.isScanning ? 'Scanning...' : 'Scan for Printers',
              isLoading: state.isScanning,
              onPressed: controller.scan,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: state.devices.length,
                itemBuilder: (context, index) {
                  final device = state.devices[index];
                  return ListTile(
                    leading: const Icon(Icons.bluetooth),
                    title: Text(device.name),
                    subtitle: Text(device.address),
                    onTap: () => controller.connect(device.address),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
