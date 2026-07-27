import 'package:equatable/equatable.dart';

class BankDetailsEntity extends Equatable {
  const BankDetailsEntity({
    required this.id,
    required this.bankName,
    required this.accountNumber,
    required this.ifscCode,
    this.branchName,
    this.accountHolderName,
  });

  final String id;
  final String bankName;
  final String accountNumber;
  final String ifscCode;
  final String? branchName;
  final String? accountHolderName;

  @override
  List<Object?> get props => [
        id,
        bankName,
        accountNumber,
        ifscCode,
        branchName,
        accountHolderName,
      ];
}
