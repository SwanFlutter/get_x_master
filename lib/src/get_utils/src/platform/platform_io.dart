import 'dart:io';

/// A utility class to check the current platform.
///
/// This class provides static getters to determine the platform on which the
/// application is running. It supports various platforms including macOS,
/// Windows, Linux, Android, iOS, and Fuchsia.
class GeneralPlatform {
  /// Returns `true` if the application is running on the web.
  ///
  /// Example:
  /// ```dart
  /// bool isWeb = GeneralPlatform.isWeb;
  /// // Result: false (since this is for IO platforms)
  /// ```
  static bool get isWeb => false;

  /// Returns `true` if the application is running on macOS.
  ///
  /// Example:
  /// ```dart
  /// bool isMacOS = GeneralPlatform.isMacOS;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isMacOS => Platform.isMacOS;

  /// Returns `true` if the application is running on Windows.
  ///
  /// Example:
  /// ```dart
  /// bool isWindows = GeneralPlatform.isWindows;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isWindows => Platform.isWindows;

  /// Returns `true` if the application is running on Linux.
  ///
  /// Example:
  /// ```dart
  /// bool isLinux = GeneralPlatform.isLinux;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isLinux => Platform.isLinux;

  /// Returns `true` if the application is running on Android.
  ///
  /// Example:
  /// ```dart
  /// bool isAndroid = GeneralPlatform.isAndroid;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isAndroid => Platform.isAndroid;

  /// Returns `true` if the application is running on iOS.
  ///
  /// Example:
  /// ```dart
  /// bool isIOS = GeneralPlatform.isIOS;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isIOS => Platform.isIOS;

  /// Returns `true` if the application is running on Fuchsia.
  ///
  /// Example:
  /// ```dart
  /// bool isFuchsia = GeneralPlatform.isFuchsia;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isFuchsia => Platform.isFuchsia;

  /// Returns `true` if the application is running on a desktop platform (macOS, Windows, or Linux).
  ///
  /// Example:
  /// ```dart
  /// bool isDesktop = GeneralPlatform.isDesktop;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;
}
