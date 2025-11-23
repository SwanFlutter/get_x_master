import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Extension for various widget utilities
extension WidgetExtensions on Widget {
  /// Padding with validation and flexible options
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").paddingAll(8.0);
  /// ```
  Widget paddingAll(double padding) {
    assert(padding >= 0, 'Padding must be non-negative');
    return Padding(padding: EdgeInsets.all(padding), child: this);
  }

  /// Symmetric padding with validation
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").paddingSymmetric(horizontal: 8.0, vertical: 16.0);
  /// ```
  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    assert(horizontal >= 0 && vertical >= 0, 'Padding must be non-negative');
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Padding only on specified sides with validation
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").paddingOnly(left: 8.0, top: 16.0);
  /// ```
  Widget paddingOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    assert(
      left >= 0 && top >= 0 && right >= 0 && bottom >= 0,
      'Padding must be non-negative',
    );
    return Padding(
      padding: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Zero padding
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").paddingZero;
  /// ```
  Widget get paddingZero => Padding(padding: EdgeInsets.zero, child: this);

  /// Margin with validation and flexible options
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").marginAll(8.0);
  /// ```
  Widget marginAll(double margin) {
    assert(margin >= 0, 'Margin must be non-negative');
    return Container(margin: EdgeInsets.all(margin), child: this);
  }

  /// Symmetric margin with validation
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").marginSymmetric(horizontal: 8.0, vertical: 16.0);
  /// ```
  Widget marginSymmetric({double horizontal = 0.0, double vertical = 0.0}) {
    assert(horizontal >= 0 && vertical >= 0, 'Margin must be non-negative');
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
      child: this,
    );
  }

  /// Margin only on specified sides with validation
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").marginOnly(left: 8.0, top: 16.0);
  /// ```
  Widget marginOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) {
    assert(
      left >= 0 && top >= 0 && right >= 0 && bottom >= 0,
      'Margin must be non-negative',
    );
    return Container(
      margin: EdgeInsets.only(
        top: top,
        left: left,
        right: right,
        bottom: bottom,
      ),
      child: this,
    );
  }

  /// Zero margin
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").marginZero;
  /// ```
  Widget get marginZero => Container(margin: EdgeInsets.zero, child: this);

  /// Background color with optional opacity
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").backgroundColor(Colors.red, opacity: 0.5);
  /// ```
  Widget backgroundColor(Color color, {double opacity = 1.0}) {
    assert(opacity >= 0 && opacity <= 1, 'Opacity must be between 0 and 1');
    return Opacity(
      opacity: opacity,
      child: Container(color: color, child: this),
    );
  }

  /// Conditionally display the widget based on the isVisible flag
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").visible(true);
  /// ```
  Widget visible(bool isVisible) {
    return isVisible ? this : const SizedBox.shrink();
  }

  /// Rotates the widget by a specified number of degrees
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").rotate(45);
  /// ```
  Widget rotate(double degrees) {
    return Transform.rotate(angle: degrees * pi / 180, child: this);
  }

  /// Scales the widget by a specified factor
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").scale(1.5);
  /// ```
  Widget scale(double scaleFactor) {
    return Transform.scale(scale: scaleFactor, child: this);
  }

  /// Formats an integer with comma-separated thousands using intl NumberFormat
  ///
  /// Example:
  /// ```dart
  /// String formattedNumber = widget.intlToNumberFormat(1234567);
  /// // Result: "1,234,567"
  /// ```
  String intlToNumberFormat(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }

  /// Adds a border to the widget with customizable color and width
  ///
  /// Example:
  /// ```dart
  /// Widget myWidget = Text("Hello").withBorder(color: Colors.red, width: 2.0);
  /// ```
  Widget withBorder({Color color = Colors.black, double width = 1.0}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: color, width: width),
      ),
      child: this,
    );
  }
}

extension WidgetSliverBoxX on Widget {
  // Enhanced Sliver conversion with optional parameters
  Widget get sliverBox => SliverToBoxAdapter(child: this);

  // Additional utility methods
  Widget sliverBoxWithKey(Key key) => SliverToBoxAdapter(key: key, child: this);
}

// New extension for responsive sizing and alignment
extension WidgetResponsiveX on Widget {
  // Expanded widget with flex factor
  Widget expand({int flex = 1}) => Expanded(flex: flex, child: this);

  // Center widget with optional dimension control
  Widget centered({bool horizontal = true, bool vertical = true}) => Center(
    widthFactor: horizontal ? null : 1.0,
    heightFactor: vertical ? null : 1.0,
    child: this,
  );
}
