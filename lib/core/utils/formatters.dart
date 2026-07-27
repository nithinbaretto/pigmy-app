import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static final _currencyFormat = NumberFormat.currency(
    locale: 'en_IN',
    symbol: '₹',
    decimalDigits: 2,
  );

  static final _dateFormat = DateFormat('dd MMM yyyy');
  static final _dateTimeFormat = DateFormat('dd MMM yyyy, hh:mm a');

  static String currency(double amount) => _currencyFormat.format(amount);

  static String date(DateTime date) => _dateFormat.format(date);

  static String dateTime(DateTime dateTime) => _dateTimeFormat.format(dateTime);
}
