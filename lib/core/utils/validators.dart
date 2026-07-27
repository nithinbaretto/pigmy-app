class Validators {
  Validators._();

  static String? required(String? value, {String fieldName = 'This field'}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? amount(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Amount is required';
    }
    final parsed = double.tryParse(value);
    if (parsed == null || parsed <= 0) {
      return 'Enter a valid amount';
    }
    return null;
  }

  static String? mobile(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Mobile number is required';
    }
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value.trim())) {
      return 'Enter a valid 10-digit mobile number';
    }
    return null;
  }

  static String? accountNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Account number is required';
    }
    if (value.trim().length < 5) {
      return 'Enter a valid account number';
    }
    return null;
  }
}
