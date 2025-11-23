import 'package:flutter/material.dart';

extension ContextExt on BuildContext {
  // === Core Media Query Properties ===
  /// Provides the size of the media query.
  Size get mediaQuerySize => MediaQuery.sizeOf(this);

  /// Returns the height of the media query.
  double get height => mediaQuerySize.height;

  /// Returns the width of the media query.
  double get width => mediaQuerySize.width;

  /// Returns the shortest side of the screen.
  double get shortestSide => mediaQuerySize.shortestSide;

  /// Returns the longest side of the screen.
  double get longestSide => mediaQuerySize.longestSide;

  /// Accesses MediaQuery data.
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Accesses padding information from MediaQuery.
  EdgeInsets get padding => MediaQuery.paddingOf(this);

  /// Accesses view padding information from MediaQuery.
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);

  /// Accesses view insets information from MediaQuery.
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);

  /// Gets the orientation of the device.
  Orientation get orientation => MediaQuery.orientationOf(this);

  /// Gets the pixel ratio of the device.
  double get devicePixelRatio => MediaQuery.devicePixelRatioOf(this);

  /// Gets text scale factor from MediaQuery.
  TextScaler get textScaler => MediaQuery.textScalerOf(this);

  // === Theme Related Properties ===
  /// Provides access to the current theme data.
  ThemeData get theme => Theme.of(this);

  /// Checks if dark mode theme is enabled.
  bool get isDarkMode => theme.brightness == Brightness.dark;

  /// Accesses icon color from the theme.
  Color? get iconColor => theme.iconTheme.color;

  /// Accesses text theme from the current theme.
  TextTheme get textTheme => theme.textTheme;

  // === Orientation Checks ===
  /// Checks if the device is in landscape mode.
  bool get isLandscape => orientation == Orientation.landscape;

  /// Checks if the device is in portrait mode.
  bool get isPortrait => orientation == Orientation.portrait;

  // === Size Transformers ===
  /// Returns a portion of the height based on [dividedBy] and [reducedBy].
  double heightTransformer({double dividedBy = 1, double reducedBy = 0.0}) {
    return (height - ((height / 100) * reducedBy)) / dividedBy;
  }

  /// Returns a portion of the width based on [dividedBy] and [reducedBy].
  double widthTransformer({double dividedBy = 1, double reducedBy = 0.0}) {
    return (width - ((width / 100) * reducedBy)) / dividedBy;
  }

  /// Divides height proportionally by a given value.
  double ratio({
    double dividedBy = 1,
    double reducedByWidth = 0.0,
    double reducedByHeight = 0.0,
  }) {
    return heightTransformer(dividedBy: dividedBy, reducedBy: reducedByHeight) /
        widthTransformer(dividedBy: dividedBy, reducedBy: reducedByWidth);
  }

  // === Device Type Detection ===
  // Breakpoints based on common device sizes
  static const double _phoneBreakpoint = 600;
  static const double _smallTabletBreakpoint = 600;
  static const double _largeTabletBreakpoint = 720;
  static const double _desktopBreakpoint = 1200;
  static const double _largeDesktopBreakpoint = 1600;
  static const double _tvBreakpoint = 1920;

  // --- Phone ---
  /// Checks if the device is a phone (shortest side < 600px).
  bool get isPhone => shortestSide < _phoneBreakpoint;

  /// Checks if width is smaller than or equal to phone size (600px).
  bool get isPhoneOrLess => width <= _phoneBreakpoint;

  /// Checks if width is greater than or equal to phone size (600px).
  bool get isPhoneOrWider => width >= _phoneBreakpoint;

  // --- Small Tablet ---
  /// Checks if the device is a small tablet (shortest side >= 600px).
  bool get isSmallTablet => shortestSide >= _smallTabletBreakpoint;

  /// Checks if width is smaller than or equal to small tablet size (600px).
  bool get isSmallTabletOrLess => width <= _smallTabletBreakpoint;

  /// Checks if width is greater than or equal to small tablet size (600px).
  bool get isSmallTabletOrWider => width >= _smallTabletBreakpoint;

  // --- Large Tablet ---
  /// Checks if the device is a large tablet (shortest side >= 720px).
  bool get isLargeTablet => shortestSide >= _largeTabletBreakpoint;

  /// Checks if width is smaller than or equal to large tablet size (720px).
  bool get isLargeTabletOrLess => width <= _largeTabletBreakpoint;

  /// Checks if width is greater than or equal to large tablet size (720px).
  bool get isLargeTabletOrWider => width >= _largeTabletBreakpoint;

  // --- General Tablet ---
  /// Checks if the device is any type of tablet.
  bool get isTablet => isSmallTablet || isLargeTablet;

  // --- Desktop ---
  /// Checks if the device is a desktop (shortest side >= 1200px).
  bool get isDesktop => shortestSide >= _desktopBreakpoint;

  /// Checks if width is smaller than or equal to desktop size (1200px).
  bool get isDesktopOrLess => width <= _desktopBreakpoint;

  /// Checks if width is greater than or equal to desktop size (1200px).
  bool get isDesktopOrWider => width >= _desktopBreakpoint;

  // --- Large Desktop ---
  /// Checks if the device is a large desktop (shortest side >= 1600px).
  bool get isLargeDesktop => shortestSide >= _largeDesktopBreakpoint;

  /// Checks if width is smaller than or equal to large desktop size (1600px).
  bool get isLargeDesktopOrLess => width <= _largeDesktopBreakpoint;

  /// Checks if width is greater than or equal to large desktop size (1600px).
  bool get isLargeDesktopOrWider => width >= _largeDesktopBreakpoint;

  // --- TV ---
  /// Checks if the device is a TV (shortest side >= 1920px).
  bool get isTV => shortestSide >= _tvBreakpoint;

  /// Checks if width is smaller than or equal to TV size (1920px).
  bool get isTVOrLess => width <= _tvBreakpoint;

  /// Checks if width is greater than or equal to TV size (1920px).
  bool get isTVOrWider => width >= _tvBreakpoint;

  // --- Navigation Bar ---
  /// Checks if width is larger than or equal to 800 pixels (for showing navigation bar).
  bool get showNavbar => width >= 800;

  // === Responsive Value ===
  /// Returns specific value according to screen size.
  T responsiveValue<T>({
    T? watch,
    T? phone,
    T? smallTablet,
    T? largeTablet,
    T? desktop,
    T? largeDesktop,
    T? tv,
  }) {
    assert(
      watch != null ||
          phone != null ||
          smallTablet != null ||
          largeTablet != null ||
          desktop != null ||
          largeDesktop != null ||
          tv != null,
      'At least one value must be provided',
    );

    final deviceWidth = width;
    final strictValues = [
      if (deviceWidth >= _tvBreakpoint) tv,
      if (deviceWidth >= _largeDesktopBreakpoint) largeDesktop,
      if (deviceWidth >= _desktopBreakpoint) desktop,
      if (deviceWidth >= _largeTabletBreakpoint) largeTablet,
      if (deviceWidth >= _smallTabletBreakpoint) smallTablet,
      if (deviceWidth >= 300) phone,
      watch,
    ].whereType<T>();

    final looseValues = [
      watch,
      phone,
      smallTablet,
      largeTablet,
      desktop,
      largeDesktop,
      tv,
    ].whereType<T>();

    return strictValues.firstOrNull ?? looseValues.first;
  }
}

extension IterableExt<T> on Iterable<T> {
  /// The first element, or `null` if the iterable is empty.
  T? get firstOrNull {
    final iterator = this.iterator;
    return iterator.moveNext() ? iterator.current : null;
  }
}
