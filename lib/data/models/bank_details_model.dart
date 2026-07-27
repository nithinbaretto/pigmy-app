import '../../domain/entities/bank_details_entity.dart';

class BankDetailsModel {
  BankDetailsModel({
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

  BankDetailsEntity toEntity() {
    return BankDetailsEntity(
      id: id,
      bankName: bankName,
      accountNumber: accountNumber,
      ifscCode: ifscCode,
      branchName: branchName,
      accountHolderName: accountHolderName,
    );
  }

  factory BankDetailsModel.fromJson(Map<String, dynamic> json) {
    return BankDetailsModel(
      id: json['id'] as String? ?? '',
      bankName: json['bank_name'] as String? ?? '',
      accountNumber: json['account_number'] as String? ?? '',
      ifscCode: json['ifsc_code'] as String? ?? '',
      branchName: json['branch_name'] as String?,
      accountHolderName: json['account_holder_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'bank_name': bankName,
        'account_number': accountNumber,
        'ifsc_code': ifscCode,
        'branch_name': branchName,
        'account_holder_name': accountHolderName,
      };
}
