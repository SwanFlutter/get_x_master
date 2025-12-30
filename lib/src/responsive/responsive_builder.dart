// ignore_for_file: unreachable_switch_default

import 'package:flutter/material.dart';

import '../get_core/get_core.dart';
import '../get_navigation/get_navigation.dart';

/// Responsive modes for different use cases
enum ResponsiveMode {
  /// Uses GetX for global responsive values (default)
  global,

  /// Uses LayoutBuilder for real-time responsive updates
  layoutBuilder,

  /// Uses MediaQuery for single-page responsive updates
  singlePage,
}

/// Real-time responsive builder that updates values instantly when screen size changes
class GetResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, ResponsiveData data) builder;
  final ResponsiveMode mode;

  const GetResponsiveBuilder({
    super.key,
    required this.builder,
    this.mode = ResponsiveMode.layoutBuilder,
  });

  @override
  Widget build(BuildContext context) {
    switch (mode) {
      case ResponsiveMode.layoutBuilder:
        return LayoutBuilder(
          builder: (context, constraints) {
            final data = ResponsiveData.fromConstraints(constraints);
            return builder(context, data);
          },
        );

      case ResponsiveMode.singlePage:
        return MediaQuery(
          data: MediaQuery.of(context),
          child: Builder(
            builder: (context) {
              final mediaQuery = MediaQuery.of(context);
              final data = ResponsiveData.fromMediaQuery(mediaQuery);
              return builder(context, data);
            },
          ),
        );

      case ResponsiveMode.global:
      default:
        final data = ResponsiveData.fromGetX();
        return builder(context, data);
    }
  }
}

/// Responsive data container with real-time calculations
class ResponsiveData {
  final double width;
  final double height;
  final String deviceType;
  final bool isLandscape;
  final bool isPortrait;
  final double aspectRatio;
  final double baseWidth;
  final double baseHeight;
  final double pixelRatio;

  const ResponsiveData({
    required this.width,
    required this.height,
    required this.deviceType,
    required this.isLandscape,
    required this.isPortrait,
    required this.aspectRatio,
    required this.baseWidth,
    required this.baseHeight,
    required this.pixelRatio,
  });

  /// Create ResponsiveData from LayoutBuilder constraints
  factory ResponsiveData.fromConstraints(BoxConstraints constraints) {
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;
    final aspectRatio = width / height;
    final deviceType = _getDeviceType(width, height);
    final baseDimensions = _getBaseDimensions(deviceType);

    return ResponsiveData(
      width: width,
      height: height,
      deviceType: deviceType,
      isLandscape: width > height,
      isPortrait: height > width,
      aspectRatio: aspectRatio,
      baseWidth: baseDimensions['width']!,
      baseHeight: baseDimensions['height']!,
      pixelRatio: 1.0, // LayoutBuilder doesn't provide pixel ratio
    );
  }

  /// Create ResponsiveData from MediaQuery
  factory ResponsiveData.fromMediaQuery(MediaQueryData mediaQuery) {
    final size = mediaQuery.size;
    final width = size.width;
    final height = size.height;
    final aspectRatio = width / height;
    final deviceType = _getDeviceType(width, height);
    final baseDimensions = _getBaseDimensions(deviceType);

    return ResponsiveData(
      width: width,
      height: height,
      deviceType: deviceType,
      isLandscape: width > height,
      isPortrait: height > width,
      aspectRatio: aspectRatio,
      baseWidth: baseDimensions['width']!,
      baseHeight: baseDimensions['height']!,
      pixelRatio: mediaQuery.devicePixelRatio,
    );
  }

  /// Create ResponsiveData from GetX
  factory ResponsiveData.fromGetX() {
    final width = Get.width;
    final height = Get.height;
    final aspectRatio = width / height;
    final deviceType = _getDeviceType(width, height);
    final baseDimensions = _getBaseDimensions(deviceType);

    return ResponsiveData(
      width: width,
      height: height,
      deviceType: deviceType,
      isLandscape: width > height,
      isPortrait: height > width,
      aspectRatio: aspectRatio,
      baseWidth: baseDimensions['width']!,
      baseHeight: baseDimensions['height']!,
      pixelRatio: Get.pixelRatio,
    );
  }

  /// Convert pixels to responsive width
  double w(double pixels) {
    final percentage = (pixels / baseWidth) * 100;
    return (width * (percentage / 100));
  }

  /// Convert pixels to responsive height
  double h(double pixels) {
    final percentage = (pixels / baseHeight) * 100;
    return (height * (percentage / 100));
  }

  /// Width percentage
  double wp(double percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');
    return (width * (percent / 100));
  }

  /// Height percentage
  double hp(double percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');
    return (height * (percent / 100));
  }

  /// Responsive font size
  double sp(double fontSize) {
    final widthScale = width / baseWidth;
    final heightScale = height / baseHeight;
    final scaleFactor = (widthScale + heightScale) / 2;

    // Device-specific adjustments - reduced for better scaling
    double deviceFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        deviceFactor = 1.0;
        break;
      case 'tablet':
        deviceFactor = 1.0;
        break;
      case 'laptop':
        deviceFactor = 1.0;
        break;
      case 'desktop':
        deviceFactor = 1.0;
        break;
    }

    final adjustedScale = scaleFactor * deviceFactor;
    final clampedScale = adjustedScale.clamp(0.8, 1.2);

    return fontSize * clampedScale;
  }

  /// Widget size (for icons, buttons, etc.)
  double ws(double size) {
    final widthScale = width / baseWidth;

    double deviceFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        deviceFactor = 1.0;
        break;
      case 'tablet':
        deviceFactor = 1.0;
        break;
      case 'laptop':
        deviceFactor = 1.0;
        break;
      case 'desktop':
        deviceFactor = 1.0;
        break;
    }

    final adjustedScale = widthScale * deviceFactor;
    final clampedScale = adjustedScale.clamp(0.8, 1.2);

    return size * clampedScale;
  }

  /// Image size
  double imgSize(double size) {
    final widthScale = width / baseWidth;

    double deviceFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        deviceFactor = 1.0;
        break;
      case 'tablet':
        deviceFactor = 1.0;
        break;
      case 'laptop':
        deviceFactor = 1.0;
        break;
      case 'desktop':
        deviceFactor = 1.0;
        break;
    }

    final adjustedScale = widthScale * deviceFactor;
    final clampedScale = adjustedScale.clamp(0.8, 1.3);

    return size * clampedScale;
  }

  /// Get responsive value based on device type
  T responsiveValue<T>({
    T? phone,
    T? tablet,
    T? laptop,
    T? desktop,
    T? tv,
    T? defaultValue,
  }) {
    switch (deviceType) {
      case 'desktop':
        return desktop ?? laptop ?? tablet ?? phone ?? defaultValue!;
      case 'tv':
        return tv ?? desktop ?? laptop ?? tablet ?? phone ?? defaultValue!;
      case 'laptop':
        return laptop ?? desktop ?? tablet ?? phone ?? defaultValue!;
      case 'tablet':
        return tablet ?? laptop ?? desktop ?? phone ?? defaultValue!;
      case 'phone':
      default:
        return phone ?? tablet ?? laptop ?? desktop ?? defaultValue!;
    }
  }

  // Device type getters
  bool get isPhone => deviceType == 'phone';
  bool get isTablet => deviceType == 'tablet';
  bool get isLaptop => deviceType == 'laptop';
  bool get isDesktop => deviceType == 'desktop';
  bool get isTv => deviceType == 'tv';

  /// Enhanced text scaling with professional responsive behavior
  /// Similar to ResponsiveSize.hsp
  double hsp(double fontSize) {
    final widthScale = width / baseWidth;
    final heightScale = height / baseHeight;
    final scaleFactor = widthScale < heightScale ? widthScale : heightScale;
    final adjustedScaleFactor = scaleFactor * (pixelRatio > 2.0 ? 0.7 : 0.9);
    final clampedScaleFactor = adjustedScaleFactor.clamp(0.7, 1.2);
    return fontSize * clampedScaleFactor;
  }

  /// Enhanced responsive font size for smaller text
  /// Similar to ResponsiveSize.ssp
  double ssp(double fontSize) {
    final widthScale = width / baseWidth;
    final heightScale = height / baseHeight;
    final scaleFactor = widthScale < heightScale ? widthScale : heightScale;
    final adjustedScaleFactor = scaleFactor * (pixelRatio > 2.0 ? 0.9 : 1.1);
    final clampedScaleFactor = adjustedScaleFactor.clamp(0.9, 1.3);
    return fontSize * clampedScaleFactor;
  }

  /// Returns the percentage this pixel value represents of screen width
  double widthPercent(double pixels) {
    if (width <= 0) return 0.0;
    return (pixels / width) * 100;
  }

  /// Returns the percentage this pixel value represents of screen height
  double heightPercent(double pixels) {
    if (height <= 0) return 0.0;
    return (pixels / height) * 100;
  }

  /// Get minimum dimension (useful for square widgets)
  double minDimension(double size) {
    final minScreen = width < height ? width : height;
    final baseMin = baseWidth < baseHeight ? baseWidth : baseHeight;
    final scale = minScreen / baseMin;

    double deviceFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        deviceFactor = 1.0;
        break;
      case 'tablet':
        deviceFactor = 1.0;
        break;
      case 'laptop':
        deviceFactor = 1.0;
        break;
      case 'desktop':
        deviceFactor = 1.0;
        break;
    }

    final adjustedScale = scale * deviceFactor;
    final clampedScale = adjustedScale.clamp(0.8, 1.2);
    return size * clampedScale;
  }

  /// Get maximum dimension
  double maxDimension(double size) {
    final maxScreen = width > height ? width : height;
    final baseMax = baseWidth > baseHeight ? baseWidth : baseHeight;
    final scale = maxScreen / baseMax;

    double deviceFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        deviceFactor = 1.0;
        break;
      case 'tablet':
        deviceFactor = 1.0;
        break;
      case 'laptop':
        deviceFactor = 1.0;
        break;
      case 'desktop':
        deviceFactor = 1.0;
        break;
    }

    final adjustedScale = scale * deviceFactor;
    final clampedScale = adjustedScale.clamp(0.8, 1.2);
    return size * clampedScale;
  }

  /// Create responsive EdgeInsets
  EdgeInsets responsiveInsets({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.only(
      left: w(left),
      top: h(top),
      right: w(right),
      bottom: h(bottom),
    );
  }

  /// Create responsive symmetric EdgeInsets
  EdgeInsets responsiveInsetsSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsets.symmetric(
      horizontal: w(horizontal),
      vertical: h(vertical),
    );
  }

  /// Create responsive EdgeInsets.all
  EdgeInsets responsiveInsetsAll(double value) {
    return EdgeInsets.all(w(value));
  }

  /// Create responsive BorderRadius
  BorderRadius responsiveBorderRadius({
    double topLeft = 0,
    double topRight = 0,
    double bottomLeft = 0,
    double bottomRight = 0,
  }) {
    return BorderRadius.only(
      topLeft: Radius.circular(w(topLeft)),
      topRight: Radius.circular(w(topRight)),
      bottomLeft: Radius.circular(w(bottomLeft)),
      bottomRight: Radius.circular(w(bottomRight)),
    );
  }

  /// Create responsive BorderRadius.circular
  BorderRadius responsiveBorderRadiusCircular(double radius) {
    return BorderRadius.circular(w(radius));
  }

  /// Get screen information
  Map<String, dynamic> get screenInfo => {
    'width': width,
    'height': height,
    'aspectRatio': aspectRatio,
    'deviceType': deviceType,
    'baseWidth': baseWidth,
    'baseHeight': baseHeight,
    'pixelRatio': pixelRatio,
    'isTablet': isTablet,
    'isPhone': isPhone,
    'isLaptop': isLaptop,
    'isDesktop': isDesktop,
    'isTv': isTv,
    'isLandscape': isLandscape,
    'isPortrait': isPortrait,
  };
}

/// Helper functions
String _getDeviceType(double width, double height) {
  if (width >= 1920 || height >= 1080) {
    return 'tv';
  } else if (width >= 1200) {
    return 'desktop';
  } else if (width >= 900) {
    return 'laptop';
  } else if (width >= 600 || (width >= 500 && width / height > 1.2)) {
    return 'tablet';
  } else {
    return 'phone';
  }
}

Map<String, double> _getBaseDimensions(String deviceType) {
  switch (deviceType) {
    case 'tv':
      return {'width': 1920.0, 'height': 1080.0};
    case 'desktop':
      return {'width': 1366.0, 'height': 768.0};
    case 'laptop':
      return {'width': 1024.0, 'height': 768.0};
    case 'tablet':
      return {'width': 768.0, 'height': 1024.0};
    case 'phone':
    default:
      return {'width': 375.0, 'height': 812.0};
  }
}

/// Extension for easy responsive building
extension GetResponsiveBuilderExtension on Widget {
  /// Wrap widget with GetResponsiveBuilder
  Widget responsiveBuilder({
    ResponsiveMode mode = ResponsiveMode.layoutBuilder,
    Widget Function(BuildContext context, ResponsiveData data, Widget child)?
    builder,
  }) {
    return GetResponsiveBuilder(
      mode: mode,
      builder: (context, data) {
        if (builder != null) {
          return builder(context, data, this);
        }
        return this;
      },
    );
  }
}

// Note: GetResponsiveHelper class has been removed from this file to avoid
// ambiguous exports. The comprehensive version is available in size_percent_extension.dart

// Note: ResponsiveSize extension has been removed from this file to avoid
// ambiguous exports. The comprehensive version is available in size_percent_extension.dart

/// Extension for Widget to provide responsive visibility and other utilities
/// Note: Renamed from ResponsiveWidgetExtension to avoid naming conflicts
extension ResponsiveVisibilityExtension on Widget {
  /// Show widget only on specific device types
  Widget responsiveVisibility({
    bool phone = true,
    bool tablet = true,
    bool laptop = true,
    bool desktop = true,
    bool tv = true,
    Widget replacement = const SizedBox.shrink(),
  }) {
    return GetResponsiveBuilder(
      builder: (context, data) {
        if (data.isPhone && !phone) return replacement;
        if (data.isTablet && !tablet) return replacement;
        if (data.isLaptop && !laptop) return replacement;
        if (data.isDesktop && !desktop) return replacement;
        if (data.isTv && !tv) return replacement;
        return this;
      },
    );
  }

  /// Apply different padding based on device type
  Widget responsivePadding({
    EdgeInsetsGeometry? phone,
    EdgeInsetsGeometry? tablet,
    EdgeInsetsGeometry? laptop,
    EdgeInsetsGeometry? desktop,
    EdgeInsetsGeometry? all,
  }) {
    return GetResponsiveBuilder(
      builder: (context, data) {
        EdgeInsetsGeometry? padding = all;
        if (data.isPhone && phone != null) padding = phone;
        if (data.isTablet && tablet != null) padding = tablet;
        if (data.isLaptop && laptop != null) padding = laptop;
        if (data.isDesktop && desktop != null) padding = desktop;

        if (padding == null) return this;
        return Padding(padding: padding, child: this);
      },
    );
  }
}
