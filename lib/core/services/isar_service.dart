import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/collection_model.dart';
import '../../data/models/sync_queue_model.dart';
import '../../data/models/transaction_model.dart';

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

class IsarService {
  Isar? _isar;

  Isar get instance {
    final isar = _isar;
    if (isar == null) {
      throw StateError('Isar has not been initialized. Call init() first.');
    }
    return isar;
  }

  Future<void> init() async {
    if (_isar != null) return;

    final dir = await getApplicationDocumentsDirectory();
    _isar = await Isar.open(
      [
        CollectionModelSchema,
        TransactionModelSchema,
        SyncQueueModelSchema,
      ],
      directory: dir.path,
    );
  }

  Future<void> close() async {
    await _isar?.close();
    _isar = null;
  }
}
