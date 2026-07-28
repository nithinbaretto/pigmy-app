import 'package:equatable/equatable.dart';

/// Represents a Pigmy customer account.
class Customer extends Equatable {
  const Customer({
    required this.id,
    required this.pigmyNumber,
    required this.customerName,
    required this.phone,
    required this.address,
    required this.openingBalance,
    required this.todayDue,
    required this.status,
    this.openDate,
  });

  final String id;
  final String pigmyNumber;
  final String customerName;
  final String phone;
  final String address;
  final double openingBalance;
  final double todayDue;
  final String status;
  final DateTime? openDate;

  Customer copyWith({
    String? id,
    String? pigmyNumber,
    String? customerName,
    String? phone,
    String? address,
    double? openingBalance,
    double? todayDue,
    String? status,
    DateTime? openDate,
  }) {
    return Customer(
      id: id ?? this.id,
      pigmyNumber: pigmyNumber ?? this.pigmyNumber,
      customerName: customerName ?? this.customerName,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      openingBalance: openingBalance ?? this.openingBalance,
      todayDue: todayDue ?? this.todayDue,
      status: status ?? this.status,
      openDate: openDate ?? this.openDate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        pigmyNumber,
        customerName,
        phone,
        address,
        openingBalance,
        todayDue,
        status,
        openDate,
      ];
}
