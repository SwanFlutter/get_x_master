import 'package:intl/intl.dart';

/// Extension for converting integers to various Duration types and formatting numbers
extension DurationExt on int {
  /// Converts an integer to a Duration in seconds
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 5.seconds;
  /// // Result: Duration(seconds: 5)
  /// ```
  Duration get seconds => Duration(seconds: this);

  /// Converts an integer to a Duration in days
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 2.days;
  /// // Result: Duration(days: 2)
  /// ```
  Duration get days => Duration(days: this);

  /// Converts an integer to a Duration in hours
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 3.hours;
  /// // Result: Duration(hours: 3)
  /// ```
  Duration get hours => Duration(hours: this);

  /// Converts an integer to a Duration in minutes
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 45.minutes;
  /// // Result: Duration(minutes: 45)
  /// ```
  Duration get minutes => Duration(minutes: this);

  /// Converts an integer to a Duration in milliseconds
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 500.milliseconds;
  /// // Result: Duration(milliseconds: 500)
  /// ```
  Duration get milliseconds => Duration(milliseconds: this);

  /// Converts an integer to a Duration in microseconds
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 1000.microseconds;
  /// // Result: Duration(microseconds: 1000)
  /// ```
  Duration get microseconds => Duration(microseconds: this);

  /// Converts an integer to a Duration in milliseconds (alias for `milliseconds`)
  ///
  /// Example:
  /// ```dart
  /// Duration duration = 500.ms;
  /// // Result: Duration(milliseconds: 500)
  /// ```
  Duration get ms => milliseconds;

  /// Formats the integer with comma-separated thousands
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = 1234567.toFormattedNumber();
  /// // Result: "1,234,567"
  /// ```
  String toFormattedNumber() {
    final formatter = NumberFormat('#,###');
    return formatter.format(this);
  }
}
