// ignore_for_file: unnecessary_this

import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../get_core/get_core.dart';
import '../get_navigation/get_navigation.dart';

/// Enhanced responsive extension for percentage-based sizing
///
/// Example:
/// ```dart
/// double fiftyPercentHeight = 50.0.hp; // 50% of screen height
/// double thirtyPercentWidth = 30.0.wp; // 30% of screen width
/// ```
extension PercentSized on double {
  /// Returns the value as a percentage of the screen height.
  ///
  /// Example:
  /// ```dart
  /// double halfScreen = 50.0.hp;
  /// ```
  double get hp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    try {
      final screenHeight = Get.height;
      if (screenHeight <= 0) {
        return this * 6.67; // Fallback assuming 667px base height
      }
      return (screenHeight * (this / 100)).roundToDouble();
    } catch (e) {
      return this * 6.67; // Fallback if GetX is not properly initialized
    }
  }

  /// Returns the value as a percentage of the screen width.
  ///
  /// Example:
  /// ```dart
  /// double thirdScreen = 33.0.wp;
  /// ```
  double get wp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    try {
      final screenWidth = Get.width;
      if (screenWidth <= 0) {
        return this * 3.75; // Fallback assuming 375px base width
      }
      return (screenWidth * (this / 100)).roundToDouble();
    } catch (e) {
      return this * 3.75; // Fallback if GetX is not properly initialized
    }
  }

  /// Converts pixel value to responsive width based on dynamic base width.
  ///
  /// Example:
  /// ```dart
  /// double responsiveWidth = 120.0.w;
  /// ```
  double get w {
    try {
      final double baseWidth = _getDynamicBaseWidth();
      final double percentage = (this / baseWidth) * 100;
      final screenWidth = Get.width;
      if (screenWidth <= 0) {
        return this * 1.0; // Fallback
      }
      return (screenWidth * (percentage / 100)).roundToDouble();
    } catch (e) {
      return this * 1.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Converts pixel value to responsive height based on dynamic base height.
  ///
  /// Example:
  /// ```dart
  /// double responsiveHeight = 80.0.h;
  /// ```
  double get h {
    try {
      final double baseHeight = _getDynamicBaseHeight();
      final double percentage = (this / baseHeight) * 100;
      final screenHeight = Get.height;
      if (screenHeight <= 0) {
        return this * 1.0; // Fallback
      }
      return (screenHeight * (percentage / 100)).roundToDouble();
    } catch (e) {
      return this * 1.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Returns the percentage this pixel value represents of screen width.
  ///
  /// Example:
  /// ```dart
  /// double percent = 100.0.widthPercent;
  /// ```
  double get widthPercent {
    try {
      final screenWidth = Get.width;
      if (screenWidth <= 0) return 0.0;
      return (this / screenWidth) * 100;
    } catch (e) {
      return 0.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Returns the percentage this pixel value represents of screen height.
  ///
  /// Example:
  /// ```dart
  /// double percent = 200.0.heightPercent;
  /// ```
  double get heightPercent {
    try {
      final screenHeight = Get.height;
      if (screenHeight <= 0) return 0.0;
      return (this / screenHeight) * 100;
    } catch (e) {
      return 0.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Converts this pixel value to actual responsive width.
  ///
  /// Example:
  /// ```dart
  /// double responsive = 100.0.toResponsiveWidth;
  /// ```
  double get toResponsiveWidth {
    try {
      final screenWidth = Get.width;
      if (screenWidth <= 0) return this * 1.0;
      return screenWidth * (this / screenWidth);
    } catch (e) {
      return this * 1.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Converts this pixel value to actual responsive height.
  ///
  /// Example:
  /// ```dart
  /// double responsive = 100.0.toResponsiveHeight;
  /// ```
  double get toResponsiveHeight {
    try {
      final screenHeight = Get.height;
      if (screenHeight <= 0) return this * 1.0;
      return screenHeight * (this / screenHeight);
    } catch (e) {
      return this * 1.0; // Fallback if GetX is not properly initialized
    }
  }
}

/// Helper functions for dynamic base dimensions
double _getDynamicBaseWidth() {
  try {
    final double currentWidth = Get.width;
    final double currentHeight = Get.height;

    if (currentWidth <= 0 || currentHeight <= 0) {
      return 375.0; // Default base width
    }

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
  } catch (e) {
    // Fallback if GetX is not properly initialized
    return 375.0; // Default base width
  }
}

double _getDynamicBaseHeight() {
  try {
    final double currentWidth = Get.width;
    final double currentHeight = Get.height;

    if (currentWidth <= 0 || currentHeight <= 0) {
      return 667.0; // Default base height
    }

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
  } catch (e) {
    // Fallback if GetX is not properly initialized
    return 667.0; // Default base height
  }
}

/// Enhanced extension for num types (int, double) to provide comprehensive responsive utilities
///
/// Example:
/// ```dart
/// double fontSize = 16.sp;
/// double iconSize = 24.ws;
/// double imageSize = 100.imgSize;
/// ```
extension ResponsiveSize on num {
  /// Smart responsive font size for all devices.
  ///
  /// Example:
  /// ```dart
  /// double fontSize = 18.sp;
  /// ```
  double get sp {
    final context = Get.context;
    if (context == null) {
      // Return a default scaled value when context is not available
      return this * 1.0;
    }
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

  /// Enhanced text scaling with professional responsive behavior.
  ///
  /// Example:
  /// ```dart
  /// double fontSize = 18.hsp;
  /// ```
  double get hsp {
    final context = Get.context;
    if (context == null) {
      // Return a default scaled value when context is not available
      return this * 1.0;
    }
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

  /// Enhanced responsive font size for smaller text.
  ///
  /// Example:
  /// ```dart
  /// double smallFont = 12.ssp;
  /// ```
  double get ssp {
    final context = Get.context;
    if (context == null) {
      // Return a default scaled value when context is not available
      return this * 1.0;
    }
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

  /// Responsive widget size for icons, buttons, and other UI elements.
  ///
  /// Example:
  /// ```dart
  /// double iconSize = 24.ws;
  /// ```
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

  /// Responsive image size for all device types.
  ///
  /// Example:
  /// ```dart
  /// double imageSize = 100.imgSize;
  /// ```
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

  /// Converts pixels to responsive width using dynamic base dimensions.
  ///
  /// Example:
  /// ```dart
  /// double responsiveWidth = 120.w;
  /// ```
  double get w {
    try {
      final double baseWidth = _getDynamicBaseWidth();
      final double percentage = (this / baseWidth) * 100;
      final screenWidth = Get.width;
      if (screenWidth <= 0) {
        // Fallback to a default value if screen width is not available
        return this * 1.0;
      }
      return (screenWidth * (percentage / 100)).roundToDouble();
    } catch (e) {
      // Fallback if GetX is not properly initialized
      return this * 1.0;
    }
  }

  /// Converts pixels to responsive height using dynamic base dimensions.
  ///
  /// Example:
  /// ```dart
  /// double responsiveHeight = 80.h;
  /// ```
  double get h {
    try {
      final double baseHeight = _getDynamicBaseHeight();
      final double percentage = (this / baseHeight) * 100;
      final screenHeight = Get.height;
      if (screenHeight <= 0) {
        // Fallback to a default value if screen height is not available
        return this * 1.0;
      }
      return (screenHeight * (percentage / 100)).roundToDouble();
    } catch (e) {
      // Fallback if GetX is not properly initialized
      return this * 1.0;
    }
  }

  /// width: 30.wp = 30% of screen width.
  ///
  /// Example:
  /// ```dart
  /// double width = 30.wp;
  /// ```
  double get wp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    try {
      final screenWidth = Get.width;
      if (screenWidth <= 0) {
        // Fallback to a default value if screen width is not available
        return this * 3.75; // Assuming 375px base width
      }
      return (screenWidth * (this / 100)).roundToDouble();
    } catch (e) {
      // Fallback if GetX is not properly initialized
      return this * 3.75; // Assuming 375px base width
    }
  }

  /// height: 50.hp = 50% of screen height.
  ///
  /// Example:
  /// ```dart
  /// double height = 50.hp;
  /// ```
  double get hp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    try {
      final screenHeight = Get.height;
      if (screenHeight <= 0) {
        // Fallback to a default value if screen height is not available
        return this * 6.67; // Assuming 667px base height
      }
      return (screenHeight * (this / 100)).roundToDouble();
    } catch (e) {
      // Fallback if GetX is not properly initialized
      return this * 6.67; // Assuming 667px base height
    }
  }

  /// Returns the percentage this pixel value represents of screen width.
  ///
  /// Example:
  /// ```dart
  /// double percent = 100.widthPercent;
  /// ```
  double get widthPercent {
    try {
      final screenWidth = Get.width;
      if (screenWidth <= 0) return 0.0;
      return (this / screenWidth) * 100;
    } catch (e) {
      return 0.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Returns the percentage this pixel value represents of screen height.
  ///
  /// Example:
  /// ```dart
  /// double percent = 200.heightPercent;
  /// ```
  double get heightPercent {
    try {
      final screenHeight = Get.height;
      if (screenHeight <= 0) return 0.0;
      return (this / screenHeight) * 100;
    } catch (e) {
      return 0.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Font size without scaling (original size).
  ///
  /// Example:
  /// ```dart
  /// double original = 16.fs;
  /// ```
  double get fs => toDouble();

  /// Responsive font size with breakpoints.
  ///
  /// Example:
  /// ```dart
  /// double fontSize = 18.spWithBreakpoints;
  /// ```
  double get spWithBreakpoints {
    try {
      double screenWidth = Get.width;
      double screenHeight = Get.height;

      if (screenWidth <= 0 || screenHeight <= 0) {
        return this * 1.0; // Fallback
      }

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
    } catch (e) {
      return this * 1.0; // Fallback if GetX is not properly initialized
    }
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
    try {
      final width = Get.width;
      if (width <= 0) return 'phone'; // Default fallback
      if (width >= 1920) return 'desktop';
      if (width >= 1200) return 'laptop';
      if (width >= 768) return 'tablet';
      return 'phone';
    } catch (e) {
      return 'phone'; // Fallback if GetX is not properly initialized
    }
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
    try {
      final percentage = (pixels / _currentBaseWidth) * 100;
      final screenWidth = Get.width;
      if (screenWidth <= 0) return pixels * 1.0;
      return (screenWidth * (percentage / 100)).roundToDouble();
    } catch (e) {
      return pixels * 1.0; // Fallback if GetX is not properly initialized
    }
  }

  static double h(double pixels) {
    try {
      final percentage = (pixels / _currentBaseHeight) * 100;
      final screenHeight = Get.height;
      if (screenHeight <= 0) return pixels * 1.0;
      return (screenHeight * (percentage / 100)).roundToDouble();
    } catch (e) {
      return pixels * 1.0; // Fallback if GetX is not properly initialized
    }
  }

  static double wp(double percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');
    try {
      final screenWidth = Get.width;
      if (screenWidth <= 0) {
        return percent * 3.75; // Fallback assuming 375px base
      }
      return (screenWidth * (percent / 100)).roundToDouble();
    } catch (e) {
      return percent * 3.75; // Fallback if GetX is not properly initialized
    }
  }

  static double hp(double percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');
    try {
      final screenHeight = Get.height;
      if (screenHeight <= 0) {
        return percent * 6.67; // Fallback assuming 667px base
      }
      return (screenHeight * (percent / 100)).roundToDouble();
    } catch (e) {
      return percent * 6.67; // Fallback if GetX is not properly initialized
    }
  }

  /// Enhanced text scaling with professional responsive behavior
  static double ssp(double fontSize) {
    try {
      final currentDevice = deviceType;
      final baseWidth = _currentBaseWidth;
      final baseHeight = _currentBaseHeight;
      final screenWidth = Get.width;
      final screenHeight = Get.height;

      if (screenWidth <= 0 || screenHeight <= 0) {
        return fontSize * 1.0; // Fallback
      }

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
    } catch (e) {
      return fontSize * 1.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Enhanced widget sizing with professional responsive behavior
  static double ws(double size) {
    try {
      final currentDevice = deviceType;
      final baseWidth = _currentBaseWidth;
      final screenWidth = Get.width;

      if (screenWidth <= 0) {
        return size * 1.0; // Fallback
      }

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
    } catch (e) {
      return size * 1.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Enhanced image sizing with professional responsive behavior
  static double imgSize(double size) {
    try {
      final currentDevice = deviceType;
      final baseWidth = _currentBaseWidth;
      final screenWidth = Get.width;

      if (screenWidth <= 0) {
        return size * 1.0; // Fallback
      }

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
    } catch (e) {
      return size * 1.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Get responsive value based on device type
  /// This version updates only when the app is restarted or hot reloaded
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

  /// Get responsive value that updates in real-time when screen size changes
  /// Use this with ResponsiveBuilder for live updates
  static Widget responsiveValueRealtime<T>({
    Widget Function(T value)? builder,
    T? phone,
    T? tablet,
    T? laptop,
    T? desktop,
    T? tv,
    T? defaultValue,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final height = constraints.maxHeight;
        String currentDevice = 'phone';

        if (width >= 1920 || height >= 1080) {
          currentDevice = 'tv';
        } else if (width >= 1200) {
          currentDevice = 'desktop';
        } else if (width >= 900) {
          currentDevice = 'laptop';
        } else if (width >= 600 || (width >= 500 && width / height > 1.2)) {
          currentDevice = 'tablet';
        }

        T value;
        switch (currentDevice) {
          case 'desktop':
            value = desktop ?? laptop ?? tablet ?? phone ?? defaultValue!;
            break;
          case 'tv':
            value = tv ?? desktop ?? laptop ?? tablet ?? phone ?? defaultValue!;
            break;
          case 'laptop':
            value = laptop ?? desktop ?? tablet ?? phone ?? defaultValue!;
            break;
          case 'tablet':
            value = tablet ?? laptop ?? desktop ?? phone ?? defaultValue!;
            break;
          case 'phone':
          default:
            value = phone ?? tablet ?? laptop ?? desktop ?? defaultValue!;
            break;
        }

        return builder!(value);
      },
    );
  }

  /// Get comprehensive screen information
  static Map<String, dynamic> get screenInfo {
    try {
      final screenWidth = Get.width;
      final screenHeight = Get.height;
      final aspectRatio =
          (screenWidth > 0 && screenHeight > 0)
              ? screenWidth / screenHeight
              : 1.0;

      return {
        'width': screenWidth,
        'height': screenHeight,
        'aspectRatio': aspectRatio,
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
    } catch (e) {
      return {
        'width': 375.0,
        'height': 667.0,
        'aspectRatio': 375.0 / 667.0,
        'deviceType': 'phone',
        'baseWidth': 375.0,
        'baseHeight': 667.0,
        'isTablet': false,
        'isPhone': true,
        'isLaptop': false,
        'isDesktop': false,
        'isLandscape': false,
        'isPortrait': true,
        'textScaleFactor': 1.0,
        'widgetScaleFactor': 1.0,
        'imageScaleFactor': 1.0,
      };
    }
  }

  // Device type getters
  static bool get isPhone => deviceType == 'phone';
  static bool get isTablet => deviceType == 'tablet';
  static bool get isLaptop => deviceType == 'laptop';
  static bool get isDesktop => deviceType == 'desktop';

  // Orientation getters
  static bool get isLandscape {
    try {
      final width = Get.width;
      final height = Get.height;
      if (width <= 0 || height <= 0) return false;
      return width > height;
    } catch (e) {
      return false; // Fallback if GetX is not properly initialized
    }
  }

  static bool get isPortrait {
    try {
      final width = Get.width;
      final height = Get.height;
      if (width <= 0 || height <= 0) return true; // Default to portrait
      return height > width;
    } catch (e) {
      return true; // Fallback if GetX is not properly initialized
    }
  }

  /// Get width percentage of current screen
  static double widthPercentage(double pixels) {
    try {
      final screenWidth = Get.width;
      if (screenWidth <= 0) return 0.0;
      return (pixels / screenWidth) * 100;
    } catch (e) {
      return 0.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Get height percentage of current screen
  static double heightPercentage(double pixels) {
    try {
      final screenHeight = Get.height;
      if (screenHeight <= 0) return 0.0;
      return (pixels / screenHeight) * 100;
    } catch (e) {
      return 0.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Get minimum dimension (useful for square widgets)
  static double minDimension(double size) {
    try {
      final screenWidth = Get.width;
      final screenHeight = Get.height;

      if (screenWidth <= 0 || screenHeight <= 0) {
        return size * 1.0; // Fallback
      }

      final minScreen = math.min(screenWidth, screenHeight);
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
    } catch (e) {
      return size * 1.0; // Fallback if GetX is not properly initialized
    }
  }

  /// Get maximum dimension
  static double maxDimension(double size) {
    try {
      final screenWidth = Get.width;
      final screenHeight = Get.height;

      if (screenWidth <= 0 || screenHeight <= 0) {
        return size * 1.0; // Fallback
      }

      final maxScreen = math.max(screenWidth, screenHeight);
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
    } catch (e) {
      return size * 1.0; // Fallback if GetX is not properly initialized
    }
  }
}

/// Widget extension for responsive sizing and padding
///
/// Example:
/// ```dart
/// Container()
///   .responsive(width: 200, height: 100, padding: EdgeInsets.all(16))
/// ```
extension ResponsiveWidgetExtension on Widget {
  /// Wraps the widget in a SizedBox and Padding with responsive width, height, and padding.
  ///
  /// [width], [height] and [padding] will be scaled responsively.
  ///
  /// Example:
  /// ```dart
  /// Text('Hello').responsive(width: 200, height: 50, padding: EdgeInsets.symmetric(horizontal: 16))
  /// ```
  Widget responsive({double? width, double? height, EdgeInsets? padding}) {
    Widget child = this;
    if (padding != null) {
      child = Padding(
        padding: EdgeInsets.only(
          left: padding.left.w,
          right: padding.right.w,
          top: padding.top.h,
          bottom: padding.bottom.h,
        ),
        child: child,
      );
    }
    if (width != null || height != null) {
      child = SizedBox(width: width?.w, height: height?.h, child: child);
    }
    return child;
  }
}
