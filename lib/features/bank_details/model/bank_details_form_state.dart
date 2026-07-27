/// Bank details model placeholder.
class BankDetailsFormState {
  const BankDetailsFormState({
    this.bankName = '',
    this.accountNumber = '',
    this.ifscCode = '',
  });

  final String bankName;
  final String accountNumber;
  final String ifscCode;
}
