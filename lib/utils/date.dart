import 'package:intl/intl.dart';

/// Formats the given date string to a `Weekday, day. MonthAbbreviation (EEEE, d. LLL)` format.
String formatDate(String date) {
  final DateTime dateTime = DateTime.parse(date);
  return DateFormat('EEEE, d. LLL').format(dateTime);
}

/// Formats the given date string to a `WeekdayAbbreviation (E)` format.
String getWeekday(String date) {
  final DateTime dateTime = DateTime.parse(date);
  return DateFormat('E').format(dateTime);
}
