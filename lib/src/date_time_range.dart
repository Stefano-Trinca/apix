import 'package:apix/apix.dart';
import 'package:flutter/material.dart';

extension DateTimeRangeEvaluationExt on DateTimeRange {
  /// Checks if the current [DateTimeRange] falls entirely within another [DateTimeRange] [other].
  ///
  /// This method evaluates if both the start and the end of the current range are respectively
  /// after the start and before the end of the [other] range. The comparison is inclusive of
  /// the start time of [other] but exclusive of its end time. This means the current range
  /// can start at the same moment as [other] but must end before [other] ends to be considered
  /// as within.
  ///
  /// Example:
  /// ```dart
  /// DateTimeRange range1 = DateTimeRange(
  ///   start: DateTime(2024, 1, 1, 9, 0), // 9:00 AM, Jan 1, 2024
  ///   end: DateTime(2024, 1, 1, 10, 0), // 10:00 AM, Jan 1, 2024
  /// );
  /// DateTimeRange range2 = DateTimeRange(
  ///   start: DateTime(2024, 1, 1, 8, 0), // 8:00 AM, Jan 1, 2024
  ///   end: DateTime(2024, 1, 1, 11, 0), // 11:00 AM, Jan 1, 2024
  /// );
  ///
  /// bool isWithin = range1.isWithIn(range2); // Returns true, range1 is within range2
  ///
  /// DateTimeRange range3 = DateTimeRange(
  ///   start: DateTime(2024, 1, 1, 10, 0), // 10:00 AM, Jan 1, 2024
  ///   end: DateTime(2024, 1, 1, 12, 0), // 12:00 PM, Jan 1, 2024
  /// );
  ///
  /// bool isNotWithin = range1.isWithIn(range3); // Returns false, range1 is not within range3
  /// ```
  ///
  /// This method is particularly useful for scheduling and calendar applications where you need
  /// to check if an event (represented by the current range) falls within a larger availability
  /// block (represented by [other]).
  bool isWithIn(DateTimeRange other) {
    return start.isBefore(other.end) && end.isAfter(other.start);
  }

  /// Checks if a specific [dateTime] falls within the [DateTimeRange].
  ///
  /// The comparison includes the start time but excludes the end time. This means
  /// if [dateTime] is exactly at the start time, it will be considered as within
  /// the range. However, if it matches the end time, it will be considered outside
  /// the range.
  ///
  /// Example:
  /// ```dart
  /// DateTime start = DateTime(2024, 1, 1, 10, 0); // 10:00 AM, Jan 1, 2024
  /// DateTime end = DateTime(2024, 1, 1, 11, 0); // 11:00 AM, Jan 1, 2024
  /// DateTimeRange range = DateTimeRange(start: start, end: end);
  ///
  /// DateTime testDateTime = DateTime(2024, 1, 1, 10, 30); // Within the range
  /// bool isWithin = range.contain(testDateTime); // Returns true
  ///
  /// DateTime edgeCaseStart = DateTime(2024, 1, 1, 10, 0); // Exactly at the start
  /// bool isStartIncluded = range.contain(edgeCaseStart); // Returns true
  ///
  /// DateTime edgeCaseEnd = DateTime(2024, 1, 1, 11, 0); // Exactly at the end
  /// bool isEndExcluded = range.contain(edgeCaseEnd); // Returns false
  /// ```
  ///
  /// This function is useful for determining if events or appointments fall within
  /// a specific time slot, taking into consideration the inclusivity of the start
  /// time and the exclusivity of the end time.
  bool contain(DateTime dateTime) {
    return (dateTime.isAtSameMomentAs(start) || dateTime.isAfter(start)) &&
        (dateTime.isBefore(end));
  }

  /// The center [DateTime] of the [DateTimeRange].
  DateTime get centerDateTime =>
      start.add(Duration(days: (totalDays / 2).floor()));

}

extension DateTimeRangeDuration on DateTimeRange {

  /// Calculates the total number of months between two dates.
  ///
  /// This property computes the total months spanned between the `start` and `end` dates,
  /// accounting for partial months. The calculation is absolute, meaning it ignores the
  /// order of the dates (i.e., `start` can be before or after `end`), ensuring the result
  /// is always positive.
  ///
  /// The calculation involves:
  /// - Finding the absolute difference in years between the two dates, converting this into months,
  ///   and then subtracting one month to adjust for the current month.
  /// - Adding the month of the `end` date and the months remaining from the `start` date until
  ///   the end of its year.
  ///
  /// Note: This calculation assumes that each month in the period contributes fully to the total count,
  /// regardless of the number of days in each month or the specific day of the month for `start` and `end`.
  ///
  /// Example:
  /// ```dart
  /// DateTime start = DateTime(2023, 1, 15); // Jan 15, 2023
  /// DateTime end = DateTime(2024, 1, 10); // Jan 10, 2024
  /// int totalMonths = totalMonths; // Assuming this getter is part of a class with `start` and `end` properties
  /// print(totalMonths); // Outputs: 11, for the months between Jan 15, 2023, and Jan 10, 2024
  /// ```
  ///
  /// Considerations:
  /// - The method might return unexpected values if `start` and `end` are in the same month and year,
  ///   due to the initial subtraction of one month.
  /// - This method does not account for the exact days within the start and end months, treating partial months
  ///   as full months in the total count.
  int get totalMonths {
    var months = ((start.year - end.year).abs() - 1) * 12;
    months += end.month + (12 - start.month);
    return months;
  }

  /// Returns the total duration of the [DateTimeRange] in days.
  int get totalDays => end.difference(start).inDays;

  /// Returns the total duration of the [DateTimeRange] in hours.
  double get totalHours => totalMinutes / 60;

  /// Returns the total duration of the [DateTimeRange] in minutes.
  int get totalMinutes => end.difference(start).inMinutes;


}


extension DateTimeRangeSpanned on DateTimeRange{

  /// Gets a list of `DateTime` objects representing each day within the date range.
  ///
  /// This getter calculates and returns a list of `DateTime` objects, one for each day from the
  /// start to the end of the DateTimeRange, inclusive. Each `DateTime` object is normalized
  /// to represent only the date portion (year, month, day) with the time set to a standard value,
  /// typically midnight, through the use of `flattenDay()`. This ensures that the time components
  /// (hours, minutes, seconds) are consistent and do not affect comparisons or list generation.
  ///
  /// Example usage:
  /// ```dart
  /// DateTimeRange range = DateTimeRange(
  ///   start: DateTime(2023, 1, 1),
  ///   end: DateTime(2023, 1, 5),
  /// );
  /// List<DateTime> dates = range.listOfDates;
  /// for (DateTime date in dates) {
  ///   print(date); // Prints each date from Jan 1, 2023, to Jan 5, 2023, inclusive.
  /// }
  /// ```
  ///
  /// This property is useful for operations requiring the enumeration of each day within a range,
  /// such as generating calendar views, scheduling, or performing date-based calculations.
  List<DateTime> get listOfDates{
    List<DateTime> dates = [];
    DateTime current = start;
    while (current.isBefore(end) || current.isAtSameMomentAs(end)) {
      dates.add(current.flattenDay());
      current = current.add(const Duration(days: 1));
    }
    return dates;
  }

}

