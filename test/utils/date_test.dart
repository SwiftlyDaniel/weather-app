import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/utils/date.dart';
import 'package:intl/intl.dart';

void main() {
  group('Date formatting', () {
    test('formatDate formats correctly to Weekday, day. MonthAbbreviation', () {
      final date = '2024-12-28';
      final formatted = formatDate(date);

      // Expected result: Friday, 28. Dec (depending on locale)
      final expected = DateFormat('EEEE, d. LLL').format(DateTime.parse(date));

      expect(formatted, equals(expected));
    });

    test('getWeekday returns correct WeekdayAbbreviation', () {
      final date = '2024-12-28';
      final weekday = getWeekday(date);

      // Expected result: Fri (depending on locale)
      final expected = DateFormat('E').format(DateTime.parse(date));

      expect(weekday, equals(expected));
    });

    test('formatDate throws error for invalid date', () {
      expect(() => formatDate('invalid-date'), throwsA(isA<FormatException>()));
    });

    test('getWeekday throws error for invalid date', () {
      expect(() => getWeekday('invalid-date'), throwsA(isA<FormatException>()));
    });
  });
}
