// ignore_for_file: unnecessary_this

import 'dart:math' as math;

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

    // Base values for different screen sizes
    const double baseWidth = 375.0; // iPhone SE width as base
    const double baseHeight = 667.0; // iPhone SE height as base

    // Calculate scale factors
    final widthScale = width / baseWidth;
    final heightScale = height / baseHeight;

    // Use the smaller scale factor to prevent oversized fonts
    final scaleFactor = widthScale < heightScale ? widthScale : heightScale;

    // Adjust scale factor based on pixel ratio
    final adjustedScaleFactor = scaleFactor * (pixelRatio > 2.0 ? 0.8 : 1.0);

    // Clamp the scale factor to prevent extreme sizes
    final clampedScaleFactor = adjustedScaleFactor.clamp(0.8, 1.4);

    // Calculate final font size
    return (this * clampedScaleFactor).toDouble();
  }

  /// Enhanced text scaling with professional responsive behavior
  double get hsp {
    final context = Get.context!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    // Base values for different screen sizes
    const double baseWidth = 375.0;
    const double baseHeight = 667.0;

    // Calculate scale factors
    final widthScale = width / baseWidth;
    final heightScale = height / baseHeight;

    // Use the smaller scale factor to prevent oversized fonts
    final scaleFactor = widthScale < heightScale ? widthScale : heightScale;

    // Adjust scale factor based on pixel ratio
    final adjustedScaleFactor = scaleFactor * (pixelRatio > 2.0 ? 0.7 : 0.9);

    // Clamp the scale factor to prevent extreme sizes
    final clampedScaleFactor = adjustedScaleFactor.clamp(0.7, 1.2);

    // Calculate final font size
    return (this * clampedScaleFactor).toDouble();
  }

  /// Enhanced responsive font size for smaller text
  double get ssp {
    final context = Get.context!;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final pixelRatio = MediaQuery.of(context).devicePixelRatio;

    // Base values for different screen sizes
    const double baseWidth = 375.0;
    const double baseHeight = 667.0;

    // Calculate scale factors
    final widthScale = width / baseWidth;
    final heightScale = height / baseHeight;

    // Use the smaller scale factor to prevent oversized fonts
    final scaleFactor = widthScale < heightScale ? widthScale : heightScale;

    // Adjust scale factor based on pixel ratio
    final adjustedScaleFactor = scaleFactor * (pixelRatio > 2.0 ? 0.9 : 1.1);

    // Clamp the scale factor to prevent extreme sizes
    final clampedScaleFactor = adjustedScaleFactor.clamp(0.9, 1.3);

    // Calculate final font size
    return (this * clampedScaleFactor).toDouble();
  }

  /// Responsive widget size for icons, buttons, and other UI elements
  double get ws {
    final context = Get.context;
    if (context == null) {
      // Return a default value or handle the null case
      return this * 1.0; // or throw an exception, or return 0.0
    }
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
    final context = Get.context;
    if (context == null) {
      // Return a default value or handle the null case
      return this * 1.0; // or throw an exception, or return 0.0
    }
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

/// Helper class for responsive calculations without context dependency
class ResponsiveHelper {
  // Base dimensions for different device types
  static const Map<String, Map<String, double>> _deviceBaseDimensions = {
    'phone': {'width': 375.0, 'height': 812.0},
    'tablet': {'width': 768.0, 'height': 1024.0},
    'laptop': {'width': 1366.0, 'height': 768.0},
    'desktop': {'width': 1920.0, 'height': 1080.0},
  };

  // Text scaling factors for different device types
  static const Map<String, double> _textScaleFactors = {
    'phone': 1.0,
    'tablet': 1.15,
    'laptop': 1.25,
    'desktop': 1.4,
  };

  // Widget scaling factors for different device types
  static const Map<String, double> _widgetScaleFactors = {
    'phone': 1.0,
    'tablet': 1.2,
    'laptop': 1.4,
    'desktop': 1.8,
  };

  // Image scaling factors for different device types
  static const Map<String, double> _imageScaleFactors = {
    'phone': 1.0,
    'tablet': 1.3,
    'laptop': 1.6,
    'desktop': 2.2,
  };

  // Clamp ranges for different device types and content types
  static const Map<String, Map<String, Map<String, double>>> _clampRanges = {
    'phone': {
      'text': {'min': 0.8, 'max': 1.3},
      'widget': {'min': 0.8, 'max': 1.3},
      'image': {'min': 0.8, 'max': 1.3},
    },
    'tablet': {
      'text': {'min': 0.9, 'max': 1.4},
      'widget': {'min': 0.9, 'max': 1.4},
      'image': {'min': 0.9, 'max': 1.4},
    },
    'laptop': {
      'text': {'min': 0.9, 'max': 1.5},
      'widget': {'min': 0.9, 'max': 1.5},
      'image': {'min': 0.9, 'max': 1.5},
    },
    'desktop': {
      'text': {'min': 1.0, 'max': 2.0},
      'widget': {'min': 1.0, 'max': 2.0},
      'image': {'min': 1.0, 'max': 2.0},
    },
  };

  /// Get current device type based on screen width
  static String get deviceType {
    final width = Get.width;
    if (width >= 1920) return 'desktop';
    if (width >= 1200) return 'laptop';
    if (width >= 768) return 'tablet';
    return 'phone';
  }

  /// Get base width for current device type
  static double get _currentBaseWidth {
    return _deviceBaseDimensions[deviceType]!['width']!;
  }

  /// Get base height for current device type
  static double get _currentBaseHeight {
    return _deviceBaseDimensions[deviceType]!['height']!;
  }

  // Basic responsive methods
  static double w(double pixels) {
    final percentage = (pixels / _currentBaseWidth) * 100;
    return (Get.width * (percentage / 100)).roundToDouble();
  }

  static double h(double pixels) {
    final percentage = (pixels / _currentBaseHeight) * 100;
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

  /// Enhanced text scaling with professional responsive behavior
  static double ssp(double fontSize) {
    final currentDevice = deviceType;
    final baseWidth = _currentBaseWidth;
    final baseHeight = _currentBaseHeight;
    final screenWidth = Get.width;
    final screenHeight = Get.height;

    // Calculate base scale factor
    final widthScale = screenWidth / baseWidth;
    final heightScale = screenHeight / baseHeight;

    // Use geometric mean for more balanced scaling
    final baseScale = math.sqrt(widthScale * heightScale);

    // Apply device-specific text scaling factor
    final deviceTextFactor = _textScaleFactors[currentDevice]!;
    final adjustedScale = baseScale * deviceTextFactor;

    // Apply clamping based on device type
    final clampRange = _clampRanges[currentDevice]!['text']!;
    final clampedScale = adjustedScale.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (fontSize * clampedScale).roundToDouble();
  }

  /// Enhanced widget sizing with professional responsive behavior
  static double ws(double size) {
    final currentDevice = deviceType;
    final baseWidth = _currentBaseWidth;
    final screenWidth = Get.width;

    // Calculate width scale
    final widthScale = screenWidth / baseWidth;

    // Apply device-specific widget scaling factor
    final deviceWidgetFactor = _widgetScaleFactors[currentDevice]!;
    final adjustedScale = widthScale * deviceWidgetFactor;

    // Apply clamping based on device type
    final clampRange = _clampRanges[currentDevice]!['widget']!;
    final clampedScale = adjustedScale.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (size * clampedScale).roundToDouble();
  }

  /// Enhanced image sizing with professional responsive behavior
  static double imgSize(double size) {
    final currentDevice = deviceType;
    final baseWidth = _currentBaseWidth;
    final screenWidth = Get.width;

    // Calculate width scale
    final widthScale = screenWidth / baseWidth;

    // Apply device-specific image scaling factor
    final deviceImageFactor = _imageScaleFactors[currentDevice]!;
    final adjustedScale = widthScale * deviceImageFactor;

    // Apply clamping based on device type
    final clampRange = _clampRanges[currentDevice]!['image']!;
    final clampedScale = adjustedScale.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (size * clampedScale).roundToDouble();
  }

  /// Get responsive value based on device type
  static T responsiveValue<T>({
    T? phone,
    T? tablet,
    T? laptop,
    T? desktop,
    T? tv,
    T? defaultValue,
  }) {
    final currentDevice = deviceType;

    switch (currentDevice) {
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

  /// Get comprehensive screen information
  static Map<String, dynamic> get screenInfo => {
    'width': Get.width,
    'height': Get.height,
    'aspectRatio': Get.width / Get.height,
    'deviceType': deviceType,
    'baseWidth': _currentBaseWidth,
    'baseHeight': _currentBaseHeight,
    'isTablet': isTablet,
    'isPhone': isPhone,
    'isLaptop': isLaptop,
    'isDesktop': isDesktop,
    'isLandscape': isLandscape,
    'isPortrait': isPortrait,
    'textScaleFactor': _textScaleFactors[deviceType]!,
    'widgetScaleFactor': _widgetScaleFactors[deviceType]!,
    'imageScaleFactor': _imageScaleFactors[deviceType]!,
  };

  // Device type getters
  static bool get isPhone => deviceType == 'phone';
  static bool get isTablet => deviceType == 'tablet';
  static bool get isLaptop => deviceType == 'laptop';
  static bool get isDesktop => deviceType == 'desktop';

  // Orientation getters
  static bool get isLandscape => Get.width > Get.height;
  static bool get isPortrait => Get.height > Get.width;

  /// Get width percentage of current screen
  static double widthPercentage(double pixels) {
    return (pixels / Get.width) * 100;
  }

  /// Get height percentage of current screen
  static double heightPercentage(double pixels) {
    return (pixels / Get.height) * 100;
  }

  /// Get minimum dimension (useful for square widgets)
  static double minDimension(double size) {
    final minScreen = math.min(Get.width, Get.height);
    final currentDevice = deviceType;
    final baseMin = math.min(_currentBaseWidth, _currentBaseHeight);

    final scale = minScreen / baseMin;
    final deviceFactor = _widgetScaleFactors[currentDevice]!;
    final adjustedScale = scale * deviceFactor;

    final clampRange = _clampRanges[currentDevice]!['widget']!;
    final clampedScale = adjustedScale.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (size * clampedScale).roundToDouble();
  }

  /// Get maximum dimension
  static double maxDimension(double size) {
    final maxScreen = math.max(Get.width, Get.height);
    final currentDevice = deviceType;
    final baseMax = math.max(_currentBaseWidth, _currentBaseHeight);

    final scale = maxScreen / baseMax;
    final deviceFactor = _widgetScaleFactors[currentDevice]!;
    final adjustedScale = scale * deviceFactor;

    final clampRange = _clampRanges[currentDevice]!['widget']!;
    final clampedScale = adjustedScale.clamp(
      clampRange['min']!,
      clampRange['max']!,
    );

    return (size * clampedScale).roundToDouble();
  }
}
