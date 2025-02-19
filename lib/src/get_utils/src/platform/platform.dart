import 'platform_stub.dart'
    if (dart.library.js_interop) 'platform_web.dart'
    if (dart.library.io) 'platform_io.dart';

/// A utility class to check the current platform.
///
/// This class provides static getters to determine the platform on which the
/// application is running. It supports various platforms including web, macOS,
/// Windows, Linux, Android, iOS, and Fuchsia.
class GetPlatform {
  /// Returns `true` if the application is running on the web.
  ///
  /// Example:
  /// ```dart
  /// bool isWeb = GetPlatform.isWeb;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isWeb => GeneralPlatform.isWeb;

  /// Returns `true` if the application is running on macOS.
  ///
  /// Example:
  /// ```dart
  /// bool isMacOS = GetPlatform.isMacOS;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isMacOS => GeneralPlatform.isMacOS;

  /// Returns `true` if the application is running on Windows.
  ///
  /// Example:
  /// ```dart
  /// bool isWindows = GetPlatform.isWindows;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isWindows => GeneralPlatform.isWindows;

  /// Returns `true` if the application is running on Linux.
  ///
  /// Example:
  /// ```dart
  /// bool isLinux = GetPlatform.isLinux;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isLinux => GeneralPlatform.isLinux;

  /// Returns `true` if the application is running on Android.
  ///
  /// Example:
  /// ```dart
  /// bool isAndroid = GetPlatform.isAndroid;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isAndroid => GeneralPlatform.isAndroid;

  /// Returns `true` if the application is running on iOS.
  ///
  /// Example:
  /// ```dart
  /// bool isIOS = GetPlatform.isIOS;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isIOS => GeneralPlatform.isIOS;

  /// Returns `true` if the application is running on Fuchsia.
  ///
  /// Example:
  /// ```dart
  /// bool isFuchsia = GetPlatform.isFuchsia;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isFuchsia => GeneralPlatform.isFuchsia;

  /// Returns `true` if the application is running on a mobile platform (iOS or Android).
  ///
  /// Example:
  /// ```dart
  /// bool isMobile = GetPlatform.isMobile;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isMobile => GetPlatform.isIOS || GetPlatform.isAndroid;

  /// Returns `true` if the application is running on a desktop platform (macOS, Windows, or Linux).
  ///
  /// Example:
  /// ```dart
  /// bool isDesktop = GetPlatform.isDesktop;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isDesktop =>
      GetPlatform.isMacOS || GetPlatform.isWindows || GetPlatform.isLinux;
}
