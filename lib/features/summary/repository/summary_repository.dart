import '../model/summary_data.dart';

/// Abstract summary repository — swap [MockSummaryRepository] with API impl later.
abstract class SummaryRepository {
  Future<SummaryData> getSummary();
}
