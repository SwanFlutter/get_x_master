import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'get_animated_builder.dart';

typedef OffsetBuilder = Offset Function(BuildContext, double);

/// A versatile animation widget that simplifies creating various transitions.
///
/// The `Animate` widget provides a simple way to apply different types of animations
/// to a child widget. It supports a variety of animation types including fade, slide,
/// scale, and more.
///
/// Example usage:
/// ```dart
/// Animate.fadeIn(
///   duration: Duration(seconds: 2),
///   child: Text('Hello, World!'),
/// ),
///
/// Animate.slideIn(
///   duration: Duration(seconds: 2),
///   direction: SlideDirection.up,
///   child: FlutterLogo(size: 100),
/// ),
/// ```
class Animate extends StatelessWidget {
  /// The duration of the animation.
  final Duration duration;

  /// The delay before the animation starts. Defaults to zero.
  final Duration? delay;

  /// A callback function that's called when the animation completes.
  final ValueSetter<AnimationController>? onComplete;

  /// The type of animation to apply.
  final AnimationType type;

  /// The starting value of the animation.
  final double begin;

  /// The ending value of the animation.
  final double end;

  /// The animation curve to use. Defaults to Curves.easeInOut.
  final Curve curve;

  /// Custom offset for slide animations (overrides default screen-based calculations)
  final double? customOffset;

  /// Colors for color animation
  final Color? beginColor;

  /// Colors for color animation
  final Color? endColor;

  /// The widget to animate.
  final Widget child;

  /// Creates an [Animate] widget.
  ///
  /// The [duration] parameter is required and specifies how long the animation
  /// should take to complete.
  ///
  /// The [child] parameter is required and represents the widget to animate.
  ///
  /// The [type] parameter is required and specifies the type of animation to apply.
  ///
  /// Other parameters like [delay], [onComplete], [begin], [end], [curve],
  /// [customOffset], [beginColor], and [endColor] are optional and provide additional
  /// customization for the animation.
  const Animate({
    super.key,
    required this.duration,
    this.delay,
    required this.child,
    this.onComplete,
    required this.type,
    this.begin = 0.0,
    this.end = 1.0,
    this.curve = Curves.easeInOut, // تغییر curve پیش‌فرض
    this.customOffset,
    this.beginColor,
    this.endColor,
  });

  /// Factory constructor for fade in animation
  factory Animate.fadeIn({
    Key? key,
    required Duration duration,
    Duration? delay,
    required Widget child,
    ValueSetter<AnimationController>? onComplete,
    Curve curve = Curves.easeInOut,
  }) {
    return Animate(
      key: key,
      duration: duration,
      delay: delay,
      onComplete: onComplete,
      type: AnimationType.fadeIn,
      curve: curve,
      child: child,
    );
  }

  /// Factory constructor for slide animations
  factory Animate.slideIn({
    Key? key,
    required Duration duration,
    Duration? delay,
    required Widget child,
    ValueSetter<AnimationController>? onComplete,
    Curve curve = Curves.easeInOut,
    required SlideDirection direction,
    double? customOffset,
  }) {
    AnimationType type;
    switch (direction) {
      case SlideDirection.left:
        type = AnimationType.slideInLeft;
        break;
      case SlideDirection.right:
        type = AnimationType.slideInRight;
        break;
      case SlideDirection.up:
        type = AnimationType.slideInUp;
        break;
      case SlideDirection.down:
        type = AnimationType.slideInDown;
        break;
    }

    return Animate(
      key: key,
      duration: duration,
      delay: delay,
      onComplete: onComplete,
      type: type,
      curve: curve,
      customOffset: customOffset,
      child: child,
    );
  }

  /// Factory constructor for scale animation
  factory Animate.scale({
    Key? key,
    required Duration duration,
    Duration? delay,
    required Widget child,
    ValueSetter<AnimationController>? onComplete,
    Curve curve = Curves.easeInOut,
    double begin = 0.0,
    double end = 1.0,
  }) {
    return Animate(
      key: key,
      duration: duration,
      delay: delay,
      onComplete: onComplete,
      type: AnimationType.scale,
      curve: curve,
      begin: begin,
      end: end,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final effectiveDelay = delay ?? Duration.zero;

    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: effectiveDelay,
      tween: Tween<double>(begin: begin, end: end),
      curve: curve,
      idleValue: begin,
      builder:
          (context, value, child) => _buildAnimation(context, value, child),
      onComplete: onComplete,
      child: child,
    );
  }

  Widget _buildAnimation(BuildContext context, double value, Widget? child) {
    switch (type) {
      case AnimationType.fadeIn:
        return Opacity(opacity: value, child: child);

      case AnimationType.fadeOut:
        return Opacity(opacity: 1 - value, child: child);

      case AnimationType.rotate:
        return Transform.rotate(angle: value * pi * 2, child: child);

      case AnimationType.scale:
        // اصلاح فرمول scale
        final scaleValue = lerpDouble(begin, end, value) ?? begin;
        return Transform.scale(scale: scaleValue, child: child);

      case AnimationType.bounce:
        return Transform.scale(
          scale: lerpDouble(begin, end, value) ?? begin,
          child: child,
        );

      case AnimationType.spin:
        return Transform.rotate(angle: value * pi * 2, child: child);

      case AnimationType.size:
        final sizeValue = lerpDouble(begin, end, value) ?? begin;
        return Transform.scale(scale: sizeValue, child: child);

      case AnimationType.blur:
        final blurValue = lerpDouble(begin, end, value) ?? begin;
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blurValue, sigmaY: blurValue),
          child: child,
        );

      case AnimationType.flip:
        return Transform(
          transform: Matrix4.rotationY(value * pi),
          alignment: Alignment.center,
          child: child,
        );

      case AnimationType.wave:
        return Transform(
          transform: Matrix4.translationValues(
            0.0,
            20.0 * sin(value * pi * 2),
            0.0,
          ),
          child: child,
        );

      case AnimationType.wobble:
        return Transform(
          transform:
              Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateZ(sin(value * pi * 2) * 0.1),
          alignment: Alignment.center,
          child: child,
        );

      case AnimationType.slideInLeft:
        final offset = customOffset ?? MediaQuery.of(context).size.width;
        return Transform.translate(
          offset: Offset(-offset * (1 - value), 0),
          child: child,
        );

      case AnimationType.slideInRight:
        final offset = customOffset ?? MediaQuery.of(context).size.width;
        return Transform.translate(
          offset: Offset(offset * (1 - value), 0),
          child: child,
        );

      case AnimationType.slideInUp:
        final offset = customOffset ?? MediaQuery.of(context).size.height;
        return Transform.translate(
          offset: Offset(0, -offset * (1 - value)),
          child: child,
        );

      case AnimationType.slideInDown:
        final offset = customOffset ?? MediaQuery.of(context).size.height;
        return Transform.translate(
          offset: Offset(0, offset * (1 - value)),
          child: child,
        );

      case AnimationType.slideOutLeft:
        final offset = customOffset ?? MediaQuery.of(context).size.width;
        return Transform.translate(
          offset: Offset(-offset * value, 0),
          child: child,
        );

      case AnimationType.slideOutRight:
        final offset = customOffset ?? MediaQuery.of(context).size.width;
        return Transform.translate(
          offset: Offset(offset * value, 0),
          child: child,
        );

      case AnimationType.slideOutUp:
        final offset = customOffset ?? MediaQuery.of(context).size.height;
        return Transform.translate(
          offset: Offset(0, -offset * value),
          child: child,
        );

      case AnimationType.slideOutDown:
        final offset = customOffset ?? MediaQuery.of(context).size.height;
        return Transform.translate(
          offset: Offset(0, offset * value),
          child: child,
        );

      case AnimationType.zoom:
        final zoomValue = lerpDouble(begin, end, value) ?? begin;
        return Transform.scale(scale: zoomValue, child: child);

      case AnimationType.color:
        final startColor = beginColor ?? Colors.transparent;
        final endColor = this.endColor ?? Colors.transparent;
        return ColorFiltered(
          colorFilter: ColorFilter.mode(
            Color.lerp(startColor, endColor, value) ?? startColor,
            BlendMode.modulate,
          ),
          child: child,
        );

      case AnimationType.elastic:
        final elasticValue = _calculateElastic(value);
        return Transform.scale(
          scale: lerpDouble(begin, end, elasticValue) ?? begin,
          child: child,
        );

      case AnimationType.shake:
        final shakeValue = sin(value * pi * 10) * (1 - value) * 10;
        return Transform.translate(offset: Offset(shakeValue, 0), child: child);
    }
  }

  // محاسبه انیمیشن elastic
  double _calculateElastic(double t) {
    if (t <= 0.0) return 0.0;
    if (t >= 1.0) return 1.0;

    const double p = 0.3;
    const double s = p / 4.0;

    return pow(2.0, -10 * t) * sin((t - s) * (2 * pi) / p) + 1.0;
  }
}

/// Enum defining the available animation types.
enum AnimationType {
  fadeIn,
  fadeOut,
  rotate,
  scale,
  bounce,
  spin,
  size,
  blur,
  flip,
  wave,
  wobble,
  slideInLeft,
  slideInRight,
  slideInUp,
  slideInDown,
  slideOutLeft,
  slideOutRight,
  slideOutUp,
  slideOutDown,
  zoom,
  color,
  elastic,
  shake,
}

/// Enum for slide directions
enum SlideDirection { left, right, up, down }
