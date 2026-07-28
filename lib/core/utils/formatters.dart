import 'package:intl/intl.dart';

class AppFormatters {
  AppFormatters._();

  static final NumberFormat _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹ ',
    decimalDigits: 0,
  );

  static final DateFormat _dateFormat = DateFormat('dd/MM/yyyy');

  static String currency(num amount) => _currencyFormat.format(amount);

  static String currencyCompact(num amount) => '${amount.toInt()} Rs.';

  static String date(DateTime date) => _dateFormat.format(date);
}
