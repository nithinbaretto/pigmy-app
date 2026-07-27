extension DateExtensions on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);

  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
