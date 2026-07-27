import 'dart:typed_data';

import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

import '../../../core/constants/storage_keys.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../../core/utils/logger.dart';
import '../../../domain/entities/collection_entity.dart';
import '../../../core/utils/formatters.dart';

class PrinterService {
  PrinterService({required SecureStorageService secureStorage})
      : _secureStorage = secureStorage;

  final SecureStorageService _secureStorage;
  BluetoothDevice? _connectedDevice;

  BluetoothDevice? get connectedDevice => _connectedDevice;

  Future<bool> get isBluetoothAvailable async {
    try {
      return await FlutterBluePlus.isSupported;
    } catch (_) {
      return false;
    }
  }

  Stream<List<ScanResult>> scanForPrinters({Duration timeout = const Duration(seconds: 10)}) {
    FlutterBluePlus.startScan(timeout: timeout);
    return FlutterBluePlus.scanResults;
  }

  Future<void> stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  Future<bool> connect(BluetoothDevice device) async {
    try {
      await device.connect(timeout: const Duration(seconds: 15));
      _connectedDevice = device;
      await _secureStorage.write(StorageKeys.printerMacAddress, device.remoteId.str);
      AppLogger.info('Connected to printer: ${device.platformName}');
      return true;
    } catch (e) {
      AppLogger.error('Failed to connect to printer', e);
      return false;
    }
  }

  Future<void> disconnect() async {
    if (_connectedDevice != null) {
      await _connectedDevice!.disconnect();
      _connectedDevice = null;
    }
  }

  Future<bool> printCollectionReceipt(CollectionEntity collection) async {
    if (_connectedDevice == null) {
      AppLogger.warning('No printer connected');
      return false;
    }

    try {
      final profile = await CapabilityProfile.load();
      final generator = Generator(PaperSize.mm58, profile);
      final bytes = <int>[];

      bytes.addAll(generator.text('PIGMY COLLECTION',
          styles: const PosStyles(align: PosAlign.center, bold: true)));
      bytes.addAll(generator.text(collection.type.label,
          styles: const PosStyles(align: PosAlign.center)));
      bytes.addAll(generator.hr());
      bytes.addAll(generator.text('Account: ${collection.accountNumber}'));
      bytes.addAll(generator.text('Customer: ${collection.customerName}'));
      bytes.addAll(generator.text('Mobile: ${collection.customerMobile}'));
      bytes.addAll(generator.text('Amount: ${Formatters.currency(collection.amount)}',
          styles: const PosStyles(bold: true)));
      bytes.addAll(generator.text('Date: ${Formatters.dateTime(collection.collectedAt)}'));
      if (collection.remarks != null) {
        bytes.addAll(generator.text('Remarks: ${collection.remarks}'));
      }
      bytes.addAll(generator.hr());
      bytes.addAll(generator.text('Thank you!',
          styles: const PosStyles(align: PosAlign.center)));
      bytes.addAll(generator.feed(2));
      bytes.addAll(generator.cut());

      await _writeToPrinter(Uint8List.fromList(bytes));
      return true;
    } catch (e) {
      AppLogger.error('Print failed', e);
      return false;
    }
  }

  Future<void> _writeToPrinter(Uint8List data) async {
    final services = await _connectedDevice!.discoverServices();
    for (final service in services) {
      for (final characteristic in service.characteristics) {
        if (characteristic.properties.write ||
            characteristic.properties.writeWithoutResponse) {
          await characteristic.write(data, withoutResponse: true);
          return;
        }
      }
    }
    throw Exception('No writable characteristic found on printer');
  }
}
