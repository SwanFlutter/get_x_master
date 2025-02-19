import 'dart:math';

/// Extension for converting doubles to various Duration types and formatting numbers
extension DoubleExt on double {
  /// Rounds the double to a specified number of fraction digits
  ///
  /// Example:
  /// ```dart
  /// double value = 3.14159;
  /// double roundedValue = value.toPrecision(2);
  /// // Result: 3.14
  /// ```
  double toPrecision(int fractionDigits) {
    var mod = pow(10, fractionDigits.toDouble()).toDouble();
    return ((this * mod).round().toDouble() / mod);
  }

  /// Converts a double to a Duration in milliseconds
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 1.5.milliseconds;
  /// // Result: Duration(milliseconds: 1)
  /// ```
  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  /// Alias for `milliseconds`
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 1.5.ms;
  /// // Result: Duration(milliseconds: 1)
  /// ```
  Duration get ms => milliseconds;

  /// Converts a double to a Duration in seconds
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 1.5.seconds;
  /// // Result: Duration(seconds: 1)
  /// ```
  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  /// Converts a double to a Duration in minutes
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 1.5.minutes;
  /// // Result: Duration(minutes: 1)
  /// ```
  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  /// Converts a double to a Duration in hours
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 1.5.hours;
  /// // Result: Duration(hours: 1)
  /// ```
  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  /// Converts a double to a Duration in days
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 1.5.days;
  /// // Result: Duration(days: 1)
  /// ```
  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());
}
