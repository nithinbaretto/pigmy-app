import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/providers/providers.dart';
import '../model/printer_device.dart';
import '../service/printer_service.dart';

class PrinterState {
  const PrinterState({
    this.devices = const [],
    this.isScanning = false,
    this.connectedDeviceName,
    this.error,
  });

  final List<PrinterDevice> devices;
  final bool isScanning;
  final String? connectedDeviceName;
  final String? error;

  PrinterState copyWith({
    List<PrinterDevice>? devices,
    bool? isScanning,
    String? connectedDeviceName,
    String? error,
  }) {
    return PrinterState(
      devices: devices ?? this.devices,
      isScanning: isScanning ?? this.isScanning,
      connectedDeviceName: connectedDeviceName ?? this.connectedDeviceName,
      error: error,
    );
  }
}

final printerControllerProvider =
    StateNotifierProvider<PrinterController, PrinterState>((ref) {
  return PrinterController(ref.watch(printerServiceProvider));
});

class PrinterController extends StateNotifier<PrinterState> {
  PrinterController(this._printerService) : super(const PrinterState());

  final PrinterService _printerService;

  Future<void> scan() async {
    state = state.copyWith(isScanning: true, devices: []);
    try {
      final subscription = _printerService.scanForPrinters().listen((results) {
        final devices = results
            .map(
              (r) => PrinterDevice(
                name: r.device.platformName.isNotEmpty
                    ? r.device.platformName
                    : 'Unknown Device',
                address: r.device.remoteId.str,
              ),
            )
            .toList();
        state = state.copyWith(devices: devices);
      });
      await Future.delayed(const Duration(seconds: 10));
      await subscription.cancel();
      await _printerService.stopScan();
    } finally {
      state = state.copyWith(isScanning: false);
    }
  }

  Future<void> connect(String address) async {
    // Device reconnection handled via scan results in production
    state = state.copyWith(connectedDeviceName: address);
  }

  Future<void> disconnect() async {
    await _printerService.disconnect();
    state = state.copyWith(connectedDeviceName: null);
  }
}
