import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension TimeOfDayExt on TimeOfDay {
  ///Time of day in seconds
  int get toSeconds => (hour * 60 * 60) + (minute * 60);

  ///Time of day in minutes
  ///
  /// (hour * 60) + minute;
  int get toMinutes => (hour * 60) + minute;

  ///TimeOfDay to String
  ///
  /// int the following format [hour]:[minute]
  ///
  /// for example 12:30
  String toStringFormat() => DateFormat('HH:mm').format(DateTime(1979,1,1,hour,minute));

}

extension TimeOfDayMath on TimeOfDay {
  ///Add Hours to [TimeOfDay]
  TimeOfDay addHours(int value) => addMinutes(value * 60);

  ///Add Minutes to [TimeOfDay]
  TimeOfDay addMinutes(int value) {
    int totMinutes = toMinutes;
    totMinutes += value;
    int nHour = totMinutes ~/ 60;
    int nMinute = totMinutes % 60;
    return TimeOfDay(hour: nHour.clamp(0, 23), minute: nMinute);
  }
}

extension TimeOfDayRound on TimeOfDay {
  ///Round time to half hour
  TimeOfDay roundToHalf() {
    if (minute <= 15) return TimeOfDay(hour: hour, minute: 0);
    if (minute <= 45) return TimeOfDay(hour: hour, minute: 30);
    if (hour == 23) {
      return const TimeOfDay(hour: 0, minute: 0);
    } else {
      return TimeOfDay(hour: hour + 1, minute: 0);
    }
  }
}

extension TimeOfDayIntParse on int {
  ///Time of Day from seconds
  TimeOfDay get fromSeconds => (this ~/ 60).fromMinutes;

  ///Time of Day from minutes
  TimeOfDay get fromMinutes => TimeOfDay(hour: this ~/ 60, minute: this % 60);
}
