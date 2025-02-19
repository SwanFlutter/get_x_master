import 'dart:developer' as developer;

import 'get_main.dart';

/// Signature for log writer functions that can be used to customize logging behavior.
///
/// [text] - The message to be logged
/// [isError] - Whether this is an error message
typedef LogWriterCallback = void Function(String text, {bool isError});

/// Default logging implementation for GetX framework.
///
/// This function handles logging messages with the following behavior:
/// - Always logs error messages regardless of log settings
/// - Only logs non-error messages if [Get.isLogEnable] is true
/// - Uses dart:developer log with 'GETX' as the log name
///
/// Example usage:
/// ```dart
/// // Log a regular message
/// defaultLogWriterCallback('Regular message');
///
/// // Log an error message
/// defaultLogWriterCallback('Error occurred', isError: true);
///
/// // Set custom log writer
/// Get.log = (String message, {bool isError = false}) {
///   // Custom logging implementation
/// };
/// ```
///
/// @param value The message to be logged
/// @param isError Whether this message should be treated as an error (default: false)
void defaultLogWriterCallback(String value, {bool isError = false}) {
  // Log if it's an error message or if logging is enabled globally
  if (isError || Get.isLogEnable) {
    developer.log(
      value,
      name: 'GETX',
    );
  }
}
