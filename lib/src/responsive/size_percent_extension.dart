// ignore_for_file: unnecessary_this

import '../../get_x_master.dart';

/// Enhanced responsive extension for percentage-based sizing
///
/// This extension provides multiple ways to handle responsive sizing:
/// 1. Percentage-based sizing (wp, hp)
/// 2. Dynamic pixel-to-responsive conversion (w, h)
/// 3. Dynamic pixel-to-percentage calculation
extension PercentSized on double {
  /// height: 50.0.hp = 50% of screen height
  ///
  /// Percent must be between 0 and 100
  double get hp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    return (Get.height * (this / 100)).roundToDouble();
  }

  /// width: 30.0.wp = 30% of screen width
  ///
  /// Percent must be between 0 and 100
  double get wp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    return (Get.width * (this / 100)).roundToDouble();
  }

  /// Convert pixels to responsive width based on dynamic base width
  ///
  /// Example: 134.w = 134px responsive width
  /// This automatically calculates the percentage and applies it using device-appropriate base dimensions
  double get w {
    final double baseWidth = _getDynamicBaseWidth();
    final double percentage = (this / baseWidth) * 100;
    return (Get.width * (percentage / 100)).roundToDouble();
  }

  /// Convert pixels to responsive height based on dynamic base height
  ///
  /// Example: 30.h = 30px responsive height
  /// This automatically calculates the percentage and applies it using device-appropriate base dimensions
  double get h {
    final double baseHeight = _getDynamicBaseHeight();
    final double percentage = (this / baseHeight) * 100;
    return (Get.height * (percentage / 100)).roundToDouble();
  }

  /// Get the percentage this pixel value represents of screen width
  ///
  /// Example: 134.widthPercent = percentage of screen width that 134px represents
  double get widthPercent {
    return (this / Get.width) * 100;
  }

  /// Get the percentage this pixel value represents of screen height
  ///
  /// Example: 30.heightPercent = percentage of screen height that 30px represents
  double get heightPercent {
    return (this / Get.height) * 100;
  }

  /// Convert this pixel value to actual responsive width
  ///
  /// Example: 134.toResponsiveWidth = actual width for 134px on current screen
  double get toResponsiveWidth {
    return Get.width * (this / Get.width);
  }

  /// Convert this pixel value to actual responsive height
  ///
  /// Example: 30.toResponsiveHeight = actual height for 30px on current screen
  double get toResponsiveHeight {
    return Get.height * (this / Get.height);
  }
}

/// Helper functions for dynamic base dimensions
/// These functions determine appropriate base dimensions based on device characteristics
double _getDynamicBaseWidth() {
  final double currentWidth = Get.width;
  final double currentHeight = Get.height;
  final double aspectRatio = currentWidth / currentHeight;

  // Determine device type and set appropriate base width
  if (currentWidth >= 1200) {
    // Desktop/Large tablet landscape
    return currentWidth * 0.3; // Use 30% of screen width as base
  } else if (currentWidth >= 800) {
    // Tablet
    return aspectRatio > 1.0 ? 600.0 : 400.0; // Landscape vs Portrait
  } else if (currentWidth >= 600) {
    // Large phone/Small tablet
    return aspectRatio > 1.0 ? 500.0 : 360.0;
  } else {
    // Phone
    return aspectRatio > 1.0 ? 400.0 : 320.0;
  }
}

double _getDynamicBaseHeight() {
  final double currentWidth = Get.width;
  final double currentHeight = Get.height;
  final double aspectRatio = currentWidth / currentHeight;

  // Determine device type and set appropriate base height
  if (currentWidth >= 1200) {
    // Desktop/Large tablet
    return currentHeight * 0.4; // Use 40% of screen height as base
  } else if (currentWidth >= 800) {
    // Tablet
    return aspectRatio > 1.0 ? 600.0 : 800.0; // Landscape vs Portrait
  } else if (currentWidth >= 600) {
    // Large phone/Small tablet
    return aspectRatio > 1.0 ? 400.0 : 640.0;
  } else {
    // Phone
    return aspectRatio > 1.0 ? 360.0 : 568.0;
  }
}

/// Enhanced extension for num types (int, double) to provide comprehensive responsive utilities
///
/// This extension provides multiple responsive sizing methods:
/// 1. Font size utilities (sp, spWithBreakpoints)
/// 2. Dynamic pixel-to-responsive conversion (w, h)
/// 3. Percentage-based sizing (wp, hp)
/// 4. Dynamic calculations
extension ResponsiveSize on num {
  /// Convert pixels to responsive width using dynamic base dimensions
  ///
  /// Example: 134.w = 134px responsive width
  double get w {
    final double baseWidth = _getDynamicBaseWidth();
    final double percentage = (this / baseWidth) * 100;
    return (Get.width * (percentage / 100)).roundToDouble();
  }

  /// Convert pixels to responsive height using dynamic base dimensions
  ///
  /// Example: 30.h = 30px responsive height
  double get h {
    final double baseHeight = _getDynamicBaseHeight();
    final double percentage = (this / baseHeight) * 100;
    return (Get.height * (percentage / 100)).roundToDouble();
  }

  /// width: 30.wp = 30% of screen width
  ///
  /// Percent must be between 0 and 100
  double get wp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    return (Get.width * (this / 100)).roundToDouble();
  }

  /// height: 50.hp = 50% of screen height
  ///
  /// Percent must be between 0 and 100
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

  double get sp => _getResponsiveFontSize(this.toDouble());
  double get fs => toDouble();

  double _getResponsiveFontSize(double fontSize) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    double baseWidth = _getDynamicBaseWidth();
    double baseHeight = _getDynamicBaseHeight();

    double widthScale = screenWidth / baseWidth;
    double heightScale = screenHeight / baseHeight;

    // Use average of width and height scale for better calculation
    double scale = (widthScale + heightScale) / 2;

    // Limit the scale to prevent extremely large or small fonts
    scale = scale.clamp(0.8, 1.3);

    return (fontSize * scale).roundToDouble();
  }

  double get spWithBreakpoints {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    // Calculate screen aspect ratio
    double aspectRatio = screenWidth / screenHeight;

    double scale;
    if (screenWidth <= 320) {
      scale = 0.8; // For small devices like iPhone SE
    } else if (screenWidth <= 375) {
      scale = 1.0; // For medium devices like iPhone X
    } else if (screenWidth <= 414) {
      scale = 1.1; // For larger devices like iPhone Plus
    } else if (aspectRatio < 0.7) {
      scale = 1.2; // For portrait tablets
    } else {
      scale = 1.3; // For landscape tablets and larger devices
    }

    return (this * scale).roundToDouble();
  }
}

/// Helper class for responsive calculations without context dependency
///
/// This class provides static methods for responsive calculations using Get.width and Get.height
/// No BuildContext required - uses GetX's global access to screen dimensions
/// All calculations use dynamic base dimensions based on current device characteristics
class ResponsiveHelper {
  /// Convert pixel width to responsive width using dynamic base dimensions
  ///
  /// Example: ResponsiveHelper.w(134) = 134px responsive width
  static double w(double pixels) {
    final double baseWidth = _getDynamicBaseWidth();
    final double percentage = (pixels / baseWidth) * 100;
    return (Get.width * (percentage / 100)).roundToDouble();
  }

  /// Convert pixel height to responsive height using dynamic base dimensions
  ///
  /// Example: ResponsiveHelper.h(30) = 30px responsive height
  static double h(double pixels) {
    final double baseHeight = _getDynamicBaseHeight();
    final double percentage = (pixels / baseHeight) * 100;
    return (Get.height * (percentage / 100)).roundToDouble();
  }

  /// Get width percentage
  ///
  /// Example: ResponsiveHelper.wp(30) = 30% of screen width
  static double wp(double percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');
    return (Get.width * (percent / 100)).roundToDouble();
  }

  /// Get height percentage
  ///
  /// Example: ResponsiveHelper.hp(50) = 50% of screen height
  static double hp(double percent) {
    assert(percent >= 0 && percent <= 100, 'Percent must be between 0 and 100');
    return (Get.height * (percent / 100)).roundToDouble();
  }

  /// Calculate what percentage a pixel value represents of screen width
  ///
  /// Example: ResponsiveHelper.widthPercentage(134) = percentage of screen width
  static double widthPercentage(double pixels) {
    return (pixels / Get.width) * 100;
  }

  /// Calculate what percentage a pixel value represents of screen height
  ///
  /// Example: ResponsiveHelper.heightPercentage(30) = percentage of screen height
  static double heightPercentage(double pixels) {
    return (pixels / Get.height) * 100;
  }

  /// Get responsive font size using dynamic base dimensions
  ///
  /// Example: ResponsiveHelper.sp(16) = 16px responsive font size
  static double sp(double fontSize) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    double baseWidth = _getDynamicBaseWidth();
    double baseHeight = _getDynamicBaseHeight();

    double widthScale = screenWidth / baseWidth;
    double heightScale = screenHeight / baseHeight;

    // Use average of width and height scale for better calculation
    double scale = (widthScale + heightScale) / 2;

    // Limit the scale to prevent extremely large or small fonts
    scale = scale.clamp(0.8, 1.3);

    return (fontSize * scale).roundToDouble();
  }

  /// Get current screen info including dynamic base dimensions
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

  /// Get the current dynamic base width being used for calculations
  static double get currentBaseWidth => _getDynamicBaseWidth();

  /// Get the current dynamic base height being used for calculations
  static double get currentBaseHeight => _getDynamicBaseHeight();

  /// Check if current screen is tablet size
  static bool get isTablet => Get.width > 600;

  /// Check if current screen is phone size
  static bool get isPhone => Get.width <= 600;

  /// Check if current screen is in landscape mode
  static bool get isLandscape => Get.width > Get.height;

  /// Check if current screen is in portrait mode
  static bool get isPortrait => Get.height > Get.width;

  /// Get responsive value based on screen size
  ///
  /// Example: ResponsiveHelper.responsiveValue(phone: 16, tablet: 20, desktop: 24)
  static T responsiveValue<T>({
    T? phone,
    T? tablet,
    T? desktop,
    T? defaultValue,
  }) {
    if (Get.width >= 1200 && desktop != null) return desktop;
    if (Get.width >= 600 && tablet != null) return tablet;
    if (phone != null) return phone;
    return defaultValue ?? phone ?? tablet ?? desktop!;
  }
}
