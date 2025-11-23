import 'package:web/web.dart' as html;

import '../../get_utils.dart';

html.Navigator _navigator = html.window.navigator;

/// A utility class to check the current platform for web applications.
///
/// This class provides static getters to determine the platform on which the
/// application is running. It supports various platforms including macOS,
/// Windows, Linux, Android, and iOS.
class GeneralPlatform {
  /// Returns `true` if the application is running on the web.
  ///
  /// Example:
  /// ```dart
  /// bool isWeb = GeneralPlatform.isWeb;
  /// // Result: true
  /// ```
  static bool get isWeb => true;

  /// Returns `true` if the application is running on macOS.
  ///
  /// Example:
  /// ```dart
  /// bool isMacOS = GeneralPlatform.isMacOS;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isMacOS =>
      _navigator.appVersion.contains('Mac OS') && !GeneralPlatform.isIOS;

  /// Returns `true` if the application is running on Windows.
  ///
  /// Example:
  /// ```dart
  /// bool isWindows = GeneralPlatform.isWindows;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isWindows => _navigator.appVersion.contains('Win');

  /// Returns `true` if the application is running on Linux.
  ///
  /// Example:
  /// ```dart
  /// bool isLinux = GeneralPlatform.isLinux;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isLinux =>
      (_navigator.appVersion.contains('Linux') ||
          _navigator.appVersion.contains('x11')) &&
      !isAndroid;

  /// Returns `true` if the application is running on Android.
  ///
  /// Example:
  /// ```dart
  /// bool isAndroid = GeneralPlatform.isAndroid;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isAndroid => _navigator.appVersion.contains('Android ');

  /// Returns `true` if the application is running on iOS.
  ///
  /// Example:
  /// ```dart
  /// bool isIOS = GeneralPlatform.isIOS;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isIOS {
    // maxTouchPoints is needed to separate iPad iOS13 vs new MacOS
    return GetUtils.hasMatch(_navigator.platform, r'/iPad|iPhone|iPod/') ||
        (_navigator.platform == 'MacIntel' && _navigator.maxTouchPoints > 1);
  }

  /// Returns `true` if the application is running on Fuchsia.
  ///
  /// Example:
  /// ```dart
  /// bool isFuchsia = GeneralPlatform.isFuchsia;
  /// // Result: false (since Fuchsia is not supported on web)
  /// ```
  static bool get isFuchsia => false;

  /// Returns `true` if the application is running on a desktop platform (macOS, Windows, or Linux).
  ///
  /// Example:
  /// ```dart
  /// bool isDesktop = GeneralPlatform.isDesktop;
  /// // Result: true or false depending on the platform
  /// ```
  static bool get isDesktop => isMacOS || isWindows || isLinux;
}
