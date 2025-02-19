import '../get_utils/get_utils.dart';

/// Extension methods for dynamic type to provide utility functions.
extension GetDynamicUtils on dynamic {
  /// Checks if the value is blank (null, empty, or only contains whitespace).
  ///
  /// Example:
  /// ```dart
  /// dynamic value = '';
  /// print(value.isBlank); // true
  /// ```
  bool? get isBlank => GetUtils.isBlank(this);

  /// Logs an error message with the runtime type of the value.
  ///
  /// [info] is an optional string to provide additional information.
  /// [logFunction] is an optional function to handle the logging.
  ///
  /// Example:
  /// ```dart
  /// dynamic value = 'some error';
  /// value.printError(info: 'An error occurred');
  /// ```
  void printError(
          {String info = '', Function logFunction = GetUtils.printFunction}) =>
      // ignore: unnecessary_this
      logFunction('Error: ${this.runtimeType}', this, info, isError: true);

  /// Logs an informational message with the runtime type of the value.
  ///
  /// [info] is an optional string to provide additional information.
  /// [printFunction] is an optional function to handle the printing.
  ///
  /// Example:
  /// ```dart
  /// dynamic value = 'some info';
  /// value.printInfo(info: 'Some information');
  /// ```
  void printInfo(
          {String info = '',
          Function printFunction = GetUtils.printFunction}) =>
      // ignore: unnecessary_this
      printFunction('Info: ${this.runtimeType}', this, info);
}
