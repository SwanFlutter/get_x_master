import 'dart:async';

import '../get_utils/get_utils.dart';

/// Extension for various numerical utilities
extension GetNumUtils on num {
  /// Check if the number is lower than another number
  ///
  /// Example:
  /// ```dart
  /// bool result = 5.isLowerThan(10);
  /// // Result: true
  /// ```
  bool isLowerThan(num b) => GetUtils.isLowerThan(this, b);

  /// Check if the number is greater than another number
  ///
  /// Example:
  /// ```dart
  /// bool result = 10.isGreaterThan(5);
  /// // Result: true
  /// ```
  bool isGreaterThan(num b) => GetUtils.isGreaterThan(this, b);

  /// Check if the number is equal to another number
  ///
  /// Example:
  /// ```dart
  /// bool result = 5.isEqual(5);
  /// // Result: true
  /// ```
  bool isEqual(num b) => GetUtils.isEqual(this, b);

  /// Utility to delay some callback (or code execution)
  ///
  /// Example:
  /// ```dart
  /// void main() async {
  ///   print('+ wait for 2 seconds');
  ///   await 2.delay();
  ///   print('- 2 seconds completed');
  ///   print('+ callback in 1.2sec');
  ///   1.delay(() => print('- 1.2sec callback called'));
  ///   print('currently running callback 1.2sec');
  /// }
  /// ```
  Future delay([FutureOr Function()? callback]) async =>
      Future.delayed(Duration(milliseconds: (this * 1000).round()), callback);
}
