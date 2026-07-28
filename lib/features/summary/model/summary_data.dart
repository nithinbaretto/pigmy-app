import 'package:equatable/equatable.dart';

class SummaryData extends Equatable {
  const SummaryData({
    required this.todayCollection,
    required this.collectedAmount,
    required this.pending,
    required this.customersVisited,
    required this.totalCustomers,
  });

  final double todayCollection;
  final double collectedAmount;
  final double pending;
  final int customersVisited;
  final int totalCustomers;

  @override
  List<Object?> get props => [
        todayCollection,
        collectedAmount,
        pending,
        customersVisited,
        totalCustomers,
      ];
}
