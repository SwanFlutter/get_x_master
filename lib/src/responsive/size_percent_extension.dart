// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';

import '../../get_x_master.dart';

/// Enhanced responsive extension for percentage-based sizing
extension PercentSized on double {
  /// height: 50.0.hp = 50% of screen height
  double get hp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    return (Get.height * (this / 100)).roundToDouble();
  }

  /// width: 30.0.wp = 30% of screen width
  double get wp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    return (Get.width * (this / 100)).roundToDouble();
  }

  /// Convert pixels to responsive width based on dynamic base width
  double get w {
    final double baseWidth = _getDynamicBaseWidth();
    final double percentage = (this / baseWidth) * 100;
    return (Get.width * (percentage / 100)).roundToDouble();
  }

  /// Convert pixels to responsive height based on dynamic base height
  double get h {
    final double baseHeight = _getDynamicBaseHeight();
    final double percentage = (this / baseHeight) * 100;
    return (Get.height * (percentage / 100)).roundToDouble();
  }

  /// Get the percentage this pixel value represents of screen width
  double get widthPercent {
    return (this / Get.width) * 100;
  }

  /// Get the percentage this pixel value represents of screen height
  double get heightPercent {
    return (this / Get.height) * 100;
  }

  /// Convert this pixel value to actual responsive width
  double get toResponsiveWidth {
    return Get.width * (this / Get.width);
  }

  /// Convert this pixel value to actual responsive height
  double get toResponsiveHeight {
    return Get.height * (this / Get.height);
  }
}

/// Helper functions for dynamic base dimensions
double _getDynamicBaseWidth() {
  final double currentWidth = Get.width;
  final double currentHeight = Get.height;
  final double aspectRatio = currentWidth / currentHeight;

  if (currentWidth >= 1200) {
    return currentWidth * 0.3;
  } else if (currentWidth >= 800) {
    return aspectRatio > 1.0 ? 600.0 : 400.0;
  } else if (currentWidth >= 600) {
    return aspectRatio > 1.0 ? 500.0 : 360.0;
  } else {
    return aspectRatio > 1.0 ? 400.0 : 320.0;
  }
}

double _getDynamicBaseHeight() {
  final double currentWidth = Get.width;
  final double currentHeight = Get.height;
  final double aspectRatio = currentWidth / currentHeight;

  if (currentWidth >= 1200) {
    return currentHeight * 0.4;
  } else if (currentWidth >= 800) {
    return aspectRatio > 1.0 ? 600.0 : 800.0;
  } else if (currentWidth >= 600) {
    return aspectRatio > 1.0 ? 400.0 : 640.0;
  } else {
    return aspectRatio > 1.0 ? 360.0 : 568.0;
  }
}

/// Enhanced extension for num types (int, double) to provide comprehensive responsive utilities
extension ResponsiveSize on num {
  /// Smart responsive font size for all devices
  double get sp {
    final context = Get.context!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    final deviceInfo = _getDeviceInfo(width, height);
    final baseWidth = deviceInfo['baseWidth'] as double;
    final baseHeight = deviceInfo['baseHeight'] as double;
    final deviceType = deviceInfo['type'] as String;

    final widthScale = width / baseWidth;
    final heightScale = height / baseHeight;
    final scaleFactor = widthScale < heightScale ? widthScale : heightScale;

    double adjustmentFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        adjustmentFactor = pixelRatio > 2.0 ? 0.85 : 1.0;
        break;
      case 'tablet':
        adjustmentFactor = pixelRatio > 2.0 ? 0.9 : 1.05;
        break;
      case 'laptop':
        adjustmentFactor = 1.1;
        break;
      case 'tv':
        adjustmentFactor = 1.3;
        break;
    }

    final adjustedScaleFactor = scaleFactor * adjustmentFactor;
    final clampRange = _getClampRange(deviceType, 'normal');
    final clampedScaleFactor = adjustedScaleFactor.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (this * clampedScaleFactor).toDouble();
  }

  /// Enhanced responsive font size for larger text
  double get hsp {
    final context = Get.context!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    final deviceInfo = _getDeviceInfo(width, height);
    final baseWidth = deviceInfo['baseWidth'] as double;
    final baseHeight = deviceInfo['baseHeight'] as double;
    final deviceType = deviceInfo['type'] as String;

    final widthScale = width / baseWidth;
    final heightScale = height / baseHeight;
    final scaleFactor = widthScale < heightScale ? widthScale : heightScale;

    double adjustmentFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        adjustmentFactor = pixelRatio > 2.0 ? 0.75 : 0.9;
        break;
      case 'tablet':
        adjustmentFactor = pixelRatio > 2.0 ? 0.85 : 1.0;
        break;
      case 'laptop':
        adjustmentFactor = 1.05;
        break;
      case 'tv':
        adjustmentFactor = 1.25;
        break;
    }

    final adjustedScaleFactor = scaleFactor * adjustmentFactor;
    final clampRange = _getClampRange(deviceType, 'large');
    final clampedScaleFactor = adjustedScaleFactor.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (this * clampedScaleFactor).toDouble();
  }

  /// Enhanced responsive font size for smaller text
  double get ssp {
    final context = Get.context!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    final deviceInfo = _getDeviceInfo(width, height);
    final baseWidth = deviceInfo['baseWidth'] as double;
    final baseHeight = deviceInfo['baseHeight'] as double;
    final deviceType = deviceInfo['type'] as String;

    final widthScale = width / baseWidth;
    final heightScale = height / baseHeight;
    final scaleFactor = widthScale < heightScale ? widthScale : heightScale;

    double adjustmentFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        adjustmentFactor = pixelRatio > 2.0 ? 0.95 : 1.1;
        break;
      case 'tablet':
        adjustmentFactor = pixelRatio > 2.0 ? 1.0 : 1.15;
        break;
      case 'laptop':
        adjustmentFactor = 1.2;
        break;
      case 'tv':
        adjustmentFactor = 1.4;
        break;
    }

    final adjustedScaleFactor = scaleFactor * adjustmentFactor;
    final clampRange = _getClampRange(deviceType, 'small');
    final clampedScaleFactor = adjustedScaleFactor.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (this * clampedScaleFactor).toDouble();
  }

  /// Responsive widget size for icons, buttons, and other UI elements
  double get ws {
    final context = Get.context!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final deviceInfo = _getDeviceInfo(width, height);
    final baseWidth = deviceInfo['baseWidth'] as double;
    final deviceType = deviceInfo['type'] as String;

    final widthScale = width / baseWidth;

    double adjustmentFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        adjustmentFactor = 1.0;
        break;
      case 'tablet':
        adjustmentFactor = 1.2;
        break;
      case 'laptop':
        adjustmentFactor = 1.4;
        break;
      case 'tv':
        adjustmentFactor = 1.8;
        break;
    }

    final adjustedScale = widthScale * adjustmentFactor;
    final clampRange = _getClampRange(deviceType, 'widget');
    final clampedScale = adjustedScale.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (this * clampedScale).toDouble();
  }

  /// Responsive image size for all device types
  double get imgSize {
    final context = Get.context!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final deviceInfo = _getDeviceInfo(width, height);
    final baseWidth = deviceInfo['baseWidth'] as double;
    final deviceType = deviceInfo['type'] as String;

    final widthScale = width / baseWidth;

    double adjustmentFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        adjustmentFactor = 1.0;
        break;
      case 'tablet':
        adjustmentFactor = 1.3;
        break;
      case 'laptop':
        adjustmentFactor = 1.6;
        break;
      case 'tv':
        adjustmentFactor = 2.2;
        break;
    }

    final adjustedScale = widthScale * adjustmentFactor;
    final clampRange = _getClampRange(deviceType, 'image');
    final clampedScale = adjustedScale.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (this * clampedScale).toDouble();
  }

  /// Convert pixels to responsive width using dynamic base dimensions
  double get w {
    final double baseWidth = _getDynamicBaseWidth();
    final double percentage = (this / baseWidth) * 100;
    return (Get.width * (percentage / 100)).roundToDouble();
  }

  /// Convert pixels to responsive height using dynamic base dimensions
  double get h {
    final double baseHeight = _getDynamicBaseHeight();
    final double percentage = (this / baseHeight) * 100;
    return (Get.height * (percentage / 100)).roundToDouble();
  }

  /// width: 30.wp = 30% of screen width
  double get wp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    return (Get.width * (this / 100)).roundToDouble();
  }

  /// height: 50.hp = 50% of screen height
  double get hp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    return (Get.height * (this / 100)).roundToDouble();
  }

  /// Get the percentage this pixel value represents of screen width
  double get widthPercent {
    return (this / Get.width) * 100;
  }

  /// Get the percentage this pixel value represents of screen height
  double get heightPercent {
    return (this / Get.height) * 100;
  }

  /// Font size without scaling (original size)
  double get fs => toDouble();

  double get spWithBreakpoints {
    double screenWidth = Get.width;
    double screenHeight = Get.height;
    double aspectRatio = screenWidth / screenHeight;

    double scale;
    if (screenWidth <= 320) {
      scale = 0.8;
    } else if (screenWidth <= 375) {
      scale = 1.0;
    } else if (screenWidth <= 414) {
      scale = 1.1;
    } else if (aspectRatio < 0.7) {
      scale = 1.2;
    } else {
      scale = 1.3;
    }

    return (this * scale).roundToDouble();
  }
}

/// Helper class for responsive calculations without context dependency
class ResponsiveHelper {
  static double w(double pixels) {
    final double baseWidth = _getDynamicBaseWidth();
    final double percentage = (pixels / baseWidth) * 100;
    return (Get.width * (percentage / 100)).roundToDouble();
  }

  static double h(double pixels) {
    final double baseHeight = _getDynamicBaseHeight();
    final double percentage = (pixels / baseHeight) * 100;
    return (Get.height * (percentage / 100)).roundToDouble();
  }

  static double wp(double percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');
    return (Get.width * (percent / 100)).roundToDouble();
  }

  static double hp(double percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');
    return (Get.height * (percent / 100)).roundToDouble();
  }

  static double widthPercentage(double pixels) {
    return (pixels / Get.width) * 100;
  }

  static double heightPercentage(double pixels) {
    return (pixels / Get.height) * 100;
  }

  static double sp(double fontSize) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;
    double baseWidth = _getDynamicBaseWidth();
    double baseHeight = _getDynamicBaseHeight();

    double widthScale = screenWidth / baseWidth;
    double heightScale = screenHeight / baseHeight;
    double scale = (widthScale + heightScale) / 2;
    scale = scale.clamp(0.8, 1.3);

    return (fontSize * scale).roundToDouble();
  }

  static Map<String, dynamic> get screenInfo => {
    'width': Get.width,
    'height': Get.height,
    'aspectRatio': Get.width / Get.height,
    'baseWidth': _getDynamicBaseWidth(),
    'baseHeight': _getDynamicBaseHeight(),
    'isTablet': Get.width > 600,
    'isPhone': Get.width <= 600,
    'isLandscape': Get.width > Get.height,
    'isPortrait': Get.height > Get.width,
  };

  static double get currentBaseWidth => _getDynamicBaseWidth();
  static double get currentBaseHeight => _getDynamicBaseHeight();
  static bool get isTablet => Get.width > 600;
  static bool get isPhone => Get.width <= 600;
  static bool get isLandscape => Get.width > Get.height;
  static bool get isPortrait => Get.height > Get.width;

  static T responsiveValue<T>({
    T? phone,
    T? tablet,
    T? laptop,
    T? tv,
    T? defaultValue,
  }) {
    final width = Get.width;
    if (width >= 1920 && tv != null) return tv;
    if (width >= 1200 && laptop != null) return laptop;
    if (width >= 768 && tablet != null) return tablet;
    if (phone != null) return phone;
    return defaultValue ?? phone ?? tablet ?? laptop ?? tv!;
  }

  static String get deviceType {
    final width = Get.width;
    final height = Get.height;
    final deviceInfo = _getDeviceInfo(width, height);
    return deviceInfo['type'] as String;
  }

  static bool get isTV => Get.width >= 1920 || Get.height >= 1080;
  static bool get isLaptop => Get.width >= 1200 && Get.width < 1920;
  static bool get isTabletEnhanced => Get.width >= 768 && Get.width < 1200;
  static bool get isPhoneEnhanced => Get.width < 768;

  static double ws(double size) {
    final width = Get.width;
    final height = Get.height;
    final deviceInfo = _getDeviceInfo(width, height);
    final baseWidth = deviceInfo['baseWidth'] as double;
    final deviceType = deviceInfo['type'] as String;

    final widthScale = width / baseWidth;

    double adjustmentFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        adjustmentFactor = 1.0;
        break;
      case 'tablet':
        adjustmentFactor = 1.2;
        break;
      case 'laptop':
        adjustmentFactor = 1.4;
        break;
      case 'tv':
        adjustmentFactor = 1.8;
        break;
    }

    final adjustedScale = widthScale * adjustmentFactor;
    final clampRange = _getClampRange(deviceType, 'widget');
    final clampedScale = adjustedScale.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (size * clampedScale).toDouble();
  }

  static double imgSize(double size) {
    final width = Get.width;
    final height = Get.height;
    final deviceInfo = _getDeviceInfo(width, height);
    final baseWidth = deviceInfo['baseWidth'] as double;
    final deviceType = deviceInfo['type'] as String;

    final widthScale = width / baseWidth;

    double adjustmentFactor = 1.0;
    switch (deviceType) {
      case 'phone':
        adjustmentFactor = 1.0;
        break;
      case 'tablet':
        adjustmentFactor = 1.3;
        break;
      case 'laptop':
        adjustmentFactor = 1.6;
        break;
      case 'tv':
        adjustmentFactor = 2.2;
        break;
    }

    final adjustedScale = widthScale * adjustmentFactor;
    final clampRange = _getClampRange(deviceType, 'image');
    final clampedScale = adjustedScale.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (size * clampedScale).toDouble();
  }
}

/// Enhanced device detection and configuration
Map<String, dynamic> _getDeviceInfo(double width, double height) {
  final aspectRatio = width / height;

  if (width >= 1920 || height >= 1080) {
    return {'type': 'tv', 'baseWidth': 1920.0, 'baseHeight': 1080.0};
  } else if (width >= 1200) {
    return {'type': 'laptop', 'baseWidth': 1366.0, 'baseHeight': 768.0};
  } else if (width >= 768 || (width >= 600 && aspectRatio > 1.2)) {
    return {
      'type': 'tablet',
      'baseWidth': aspectRatio > 1.0 ? 1024.0 : 768.0,
      'baseHeight': aspectRatio > 1.0 ? 768.0 : 1024.0,
    };
  } else {
    return {'type': 'phone', 'baseWidth': 375.0, 'baseHeight': 667.0};
  }
}

/// Device-specific clamp ranges for different content types
Map<String, double> _getClampRange(String deviceType, String contentType) {
  switch (deviceType) {
    case 'phone':
      switch (contentType) {
        case 'normal':
          return {'min': 0.8, 'max': 1.4};
        case 'large':
          return {'min': 0.7, 'max': 1.2};
        case 'small':
          return {'min': 0.9, 'max': 1.3};
        case 'widget':
          return {'min': 0.8, 'max': 1.3};
        case 'image':
          return {'min': 0.7, 'max': 1.4};
        default:
          return {'min': 0.8, 'max': 1.4};
      }
    case 'tablet':
      switch (contentType) {
        case 'normal':
          return {'min': 0.9, 'max': 1.6};
        case 'large':
          return {'min': 0.8, 'max': 1.4};
        case 'small':
          return {'min': 1.0, 'max': 1.5};
        case 'widget':
          return {'min': 1.0, 'max': 1.5};
        case 'image':
          return {'min': 0.9, 'max': 1.7};
        default:
          return {'min': 0.9, 'max': 1.6};
      }
    case 'laptop':
      switch (contentType) {
        case 'normal':
          return {'min': 1.0, 'max': 1.8};
        case 'large':
          return {'min': 0.9, 'max': 1.6};
        case 'small':
          return {'min': 1.1, 'max': 1.7};
        case 'widget':
          return {'min': 1.2, 'max': 1.8};
        case 'image':
          return {'min': 1.0, 'max': 2.0};
        default:
          return {'min': 1.0, 'max': 1.8};
      }
    case 'tv':
      switch (contentType) {
        case 'normal':
          return {'min': 1.2, 'max': 2.2};
        case 'large':
          return {'min': 1.1, 'max': 2.0};
        case 'small':
          return {'min': 1.3, 'max': 2.1};
        case 'widget':
          return {'min': 1.5, 'max': 2.5};
        case 'image':
          return {'min': 1.4, 'max': 2.8};
        default:
          return {'min': 1.2, 'max': 2.2};
      }
    default:
      return {'min': 0.8, 'max': 1.4};
  }
}
