import 'package:equatable/equatable.dart';

enum PaymentMode { cash, cheque, upi }

enum TransactionStatus { completed, pending, failed }

class Transaction extends Equatable {
  const Transaction({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.pigmyNumber,
    required this.amount,
    required this.date,
    required this.status,
    this.paymentMode = PaymentMode.cash,
  });

  final String id;
  final String customerId;
  final String customerName;
  final String pigmyNumber;
  final double amount;
  final DateTime date;
  final TransactionStatus status;
  final PaymentMode paymentMode;

  @override
  List<Object?> get props => [
        id,
        customerId,
        customerName,
        pigmyNumber,
        amount,
        date,
        status,
        paymentMode,
      ];
}
