// ignore_for_file: unnecessary_this

import '../../get_x_master.dart';

extension PercentSized on double {
  /// height: 50.0.hp = 50%
  ///
  /// Percent must be between 0 and 100
  double get hp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    return (Get.height * (this / 100)).roundToDouble();
  }

  /// width: 30.0.wp = 30%
  ///
  /// Percent must be between 0 and 100
  double get wp {
    assert(this >= 0 && this <= 100, 'Percent must be between 0 and 100');
    return (Get.width * (this / 100)).roundToDouble();
  }
}

/// Extension on `num` to provide responsive font size utilities.
///
/// This extension provides methods to calculate responsive font sizes
/// based on the screen dimensions. It includes methods to get a responsive
/// font size (`sp`) and a responsive font size with breakpoints (`spWithBreakpoints`).
///
/// Methods:
/// - `double get sp`: Calculates a responsive font size based on the screen
///   dimensions and a base design size (iPhone X). It uses an average of width
///   and height scales for better calculation and limits the scale to prevent
///   extremely large or small fonts.
/// - `double get fs`: Returns the original font size as a double.
/// - `double get spWithBreakpoints`: Calculates a responsive font size based on
///   predefined breakpoints for different screen widths and aspect ratios. This
///   method provides more control over the scaling for different device types.
extension ResponsiveSize on num {
  double get sp => _getResponsiveFontSize(this.toDouble());
  double get fs => toDouble();

  double _getResponsiveFontSize(double fontSize) {
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    double baseWidth = 375.0; // Base design for iPhone X
    double baseHeight = 812.0; // Height of iPhone X

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
