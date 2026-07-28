import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/summary_data.dart';
import '../../../shared/providers/repository_providers.dart';

final summaryProvider = FutureProvider<SummaryData>((ref) async {
  final repo = ref.watch(summaryRepositoryProvider);
  return repo.getSummary();
});
