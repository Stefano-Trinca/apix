import 'package:apix/apix.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeFlatten on DateTime {

  /// Flattend the [DateTime] to year
  ///
  /// DateTime(year)
  DateTime flattenYear() => DateTime(year);

  /// Flattend the [DateTime] to month
  ///
  /// DateTime(year,month)
  DateTime flattenMonth() => DateTime(year, month);

  /// Flattend the [DateTime] to day
  ///
  /// DateTime(year,month,day)
  DateTime flattenDay() => DateTime(year, month, day);

  /// Flattend the [DateTime] to hour
  ///
  /// DateTime(year,month,day,hour)
  DateTime flattenHours() => DateTime(year, month, day, hour);

  /// Flattend the [DateTime] to minutes
  ///
  /// DateTime(year,month,day,hour,minute)
  DateTime flattenMinutes() => DateTime(year, month, day, hour, minute);
}

extension DateTimeAdd on DateTime {
  /// Add Days to DateTime
  DateTime addDays(int num) => add(num.days);

  /// Add Month to [DateTime]
  DateTime addMonths(int num) {
    int nMonth = month + num;
    if (nMonth >= 0) {
      //adding
      int nYear = year + (nMonth ~/ 12);
      return copyWith(year: nYear, month: nMonth);
    } else {
      //Subtrac
      int nYear = year - ((nMonth.abs() + 12) ~/ 12);
      nMonth = 12 - (nMonth.abs() % 12);
      return copyWith(year: nYear, month: nMonth);
    }
  }
}

extension DateTimeEvaluations on DateTime {
  ///Determinate if the DateTime is the Same Day
  bool isSameDay(DateTime date) =>
      (date.year == year) && (date.month == month) && (date.day == day);

  /// Determinate if the [DateTime] is Today
  bool get isToday => isSameDay(DateTime.now());

  /// Determinate if the [DateTime] is Tomorrow
  bool get isTomorrow => flattenDay().difference(DateTime.now().flattenDay()).inDays == 1;

  /// Determinate if the [DateTime] is Yesterday
  bool get isYesterday => flattenDay().difference(DateTime.now().flattenDay()).inDays == -1;

  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int get weekNumber {
    final dayOfYear = int.parse(DateFormat('D').format(this));
    return ((dayOfYear - weekday + 10) / 7).floor();
  }

  /// Calculates and returns the `DateTimeRange` for the week containing this `DateTime`.
  ///
  /// The week range starts from Monday (inclusive) and ends on Sunday (inclusive),
  /// based on the ISO 8601 standard, where Monday is considered the first day of the week.
  /// This method calculates the start of the week by subtracting the current day's weekday number
  /// minus one from the current date. The end of the week is then determined by adding six days
  /// to the start of the week.
  ///
  /// Returns:
  /// - A `DateTimeRange` object representing the start and end of the week.
  ///
  /// Example:
  /// ```dart
  /// DateTime now = DateTime.now();
  /// DateTimeRange thisWeek = now.weekRange;
  /// print("Week starts on: ${thisWeek.start} and ends on: ${thisWeek.end}");
  /// ```
  DateTimeRange get weekRange{
      DateTime startOfWeek = subtract(Duration(days: weekday - 1));
      DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));
      return DateTimeRange(start: startOfWeek, end: endOfWeek);
  }

  /// Calculates and returns the `DateTimeRange` for the weekend of the week containing this `DateTime`.
  ///
  /// The weekend range starts from Saturday (inclusive) and ends on Sunday (inclusive).
  /// This method first calculates the start of the week as Monday, then determines the start of
  /// the weekend by adding five days to the start of the week. The end of the weekend is
  /// calculated by adding one more day to the start of the weekend.
  ///
  /// Returns:
  /// - A `DateTimeRange` object representing the start and end of the weekend.
  ///
  /// Example:
  /// ```dart
  /// DateTime now = DateTime.now();
  /// DateTimeRange thisWeekend = now.weekendRange;
  /// print("Weekend starts on: ${thisWeekend.start} and ends on: ${thisWeekend.end}");
  /// ```
  DateTimeRange get weekendRange {
    DateTime startOfWeek = subtract(Duration(days: weekday - 1));
    DateTime startOfWeekend = startOfWeek.add(const Duration(days: 5));
    DateTime endOfWeekend = startOfWeekend.add(const Duration(days: 1));
    return DateTimeRange(start: startOfWeekend, end: endOfWeekend);
  }

}

extension IntSinceEpocheExt on int? {
  ///Create DateTime from Milliseconds Since Epoch
  ///
  /// If number is null return null
  DateTime? get millisecondSinceEpochToDateTime =>
      this == null ? null : DateTime.fromMillisecondsSinceEpoch(this!);

  ///Create DateTime from Seconds Since Epoch
  ///
  /// If number is null return null
  DateTime? get secondSinceEpochToDateTime =>
      this == null ? null : DateTime.fromMillisecondsSinceEpoch(this! * 1000);
}

extension DateTimeSinceEpochExt on DateTime {
  ///Transform [DateTime] into int value of seconds since Epoche (1970)
  int get secondsSinceEpoch => millisecondsSinceEpoch ~/ 1000;

  ///Transform [DateTime] into int value of minutes since Epoche (1970)
  int get minutesSinceEpoch => millisecondsSinceEpoch ~/ (60 * 1000);

  ///Transform [DateTime] into int value of hours since Epoche (1970)
  int get hoursSinceEpoch => millisecondsSinceEpoch ~/ (60 * 60 * 1000);

  ///Transform [DateTime] into int value of days since Epoche (1970)
  int get daysSinceEpoch => (hoursSinceEpoch / 24).round();
}

extension DateTimeStringConvert on DateTime {
  /// Format a [DateTime]
  String format(String format) => DateFormat(format).format(this);

  /// Data in formato
  ///
  /// formato: dd/MM/yyyy
  ///
  /// ex: 16/04/2021
  String get dateToString => format('dd/MM/yyyy');

  /// Data in formato
  ///
  /// formato: dd.MM.yyyy
  ///
  /// ex: 16.04.2021
  String get dateDotToString => format('dd.MM.yyyy');

  /// Date with month name
  ///
  /// formato: dd MMMM yyyy
  ///
  /// ex: 16 Aprile 2021
  String get dateMonthNameToString => format('dd MMMM yyyy').capitalize();

  /// Data in formato normale/comune con giorno settimana
  ///
  /// formato: EEEE dd/MM/yyyy
  ///
  /// ex: Venerdì 16/04/2021
  String get weekDateToString => format('EEEE dd/MM/yyyy').capitalizeFirst();

  /// Giorno della settimana
  ///
  /// formato: EEEE
  ///
  /// ex: Venerdì
  String get weekDayToString => format('EEEE').capitalizeFirst();

  /// Formato ora standard
  ///
  /// formato: HH:mm
  ///
  /// ex: 10:43
  String get timeOfDayToString => format('HH:mm');

  /// Formato ora standard con secondi
  ///
  /// formato: HH:mm:ss
  ///
  /// ex: 10:43:53
  String get fullTimeOfDayToString => format('HH:mm:ss');



}
