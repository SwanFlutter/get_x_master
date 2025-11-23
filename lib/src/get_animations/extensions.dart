import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'animations.dart';
import 'get_animated_builder.dart';

const _defaultDuration = Duration(seconds: 2);
const _defaultDelay = Duration.zero;

/// Slide animation type
enum SlideType { left, right, top, bottom }

/// Extension methods for adding animations to any Widget.
/// These extensions provide a concise and convenient way to apply various
/// animations to widgets using a fluent API.
extension AnimationExtension on Widget {
  /// Returns the current animation if this widget is already animated by [GetAnimatedBuilder].
  /// This is used internally to manage sequential animations.
  GetAnimatedBuilder? get _currentAnimation =>
      (this is GetAnimatedBuilder) ? this as GetAnimatedBuilder : null;

  /// Adds a fade-in animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.fadeIn(duration: Duration(seconds: 1), delay: Duration(milliseconds: 500));
  /// ```
  GetAnimatedBuilder fadeIn({
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    assert(
      isSequential || this is! GetAnimatedBuilder,
      'Can not use fadeOut + fadeIn when isSequential is false',
    );

    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      idleValue: 0.0,
      onComplete: onComplete,
      builder: (context, value, child) => Opacity(opacity: value, child: child),
      child: this,
    );
  }

  /// Adds a fade-out animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.fadeOut(duration: Duration(seconds: 1));
  /// ```
  GetAnimatedBuilder fadeOut({
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    assert(
      isSequential || this is! GetAnimatedBuilder,
      'Cannot use fadeOut() + fadeIn() when isSequential is false',
    );

    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      idleValue: 1.0,
      onComplete: onComplete,
      builder:
          (context, value, child) => Opacity(opacity: 1 - value, child: child),
      child: this,
    );
  }

  /// Adds a rotation animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.rotate(begin: 0, end: 1); // Full rotation
  /// ```
  GetAnimatedBuilder rotate({
    required double begin,
    required double end,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: begin, end: end),
      idleValue: begin,
      onComplete: onComplete,
      builder:
          (context, value, child) =>
              Transform.rotate(angle: value * pi * 2, child: child),
      child: this,
    );
  }

  /// Adds a scale animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.scale(begin: 0.5, end: 1.5); // Scales from half to 1.5x size
  /// ```
  GetAnimatedBuilder scale({
    required double begin,
    required double end,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: begin, end: end),
      idleValue: begin,
      onComplete: onComplete,
      builder:
          (context, value, child) =>
              Transform.scale(scale: value, child: child),
      child: this,
    );
  }

  /// Adds a slide animation to the widget with predefined slide types.
  ///
  /// Example:
  /// ```dart
  /// // Slide in from the left
  /// myWidget.slideIn(type: SlideType.left);
  ///
  /// // Slide in from the top with custom distance
  /// myWidget.slideIn(type: SlideType.top, distance: 200);
  /// ```
  GetAnimatedBuilder slideIn({
    SlideType type = SlideType.left,
    double distance = 1.0,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: 1.0, end: 0.0),
      idleValue: 1.0,
      onComplete: onComplete,
      builder: (context, value, child) {
        late Offset offset;
        switch (type) {
          case SlideType.left:
            offset = Offset(-value * distance, 0);
            break;
          case SlideType.right:
            offset = Offset(value * distance, 0);
            break;
          case SlideType.top:
            offset = Offset(0, -value * distance);
            break;
          case SlideType.bottom:
            offset = Offset(0, value * distance);
            break;
        }
        return Transform.translate(offset: offset, child: child);
      },
      child: this,
    );
  }

  /// Adds a slide-out animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.slideOut(type: SlideType.right);
  /// ```
  GetAnimatedBuilder slideOut({
    SlideType type = SlideType.left,
    double distance = 1.0,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      idleValue: 0.0,
      onComplete: onComplete,
      builder: (context, value, child) {
        late Offset offset;
        switch (type) {
          case SlideType.left:
            offset = Offset(-value * distance, 0);
            break;
          case SlideType.right:
            offset = Offset(value * distance, 0);
            break;
          case SlideType.top:
            offset = Offset(0, -value * distance);
            break;
          case SlideType.bottom:
            offset = Offset(0, value * distance);
            break;
        }
        return Transform.translate(offset: offset, child: child);
      },
      child: this,
    );
  }

  /// Adds a slide animation to the widget (legacy method for backward compatibility).
  ///
  /// Example:
  /// ```dart
  /// myWidget.slide(offset: (context, value) => Offset(-value, 0));
  /// ```
  GetAnimatedBuilder slide({
    required OffsetBuilder offset,
    double begin = 0,
    double end = 1,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: begin, end: end),
      idleValue: begin,
      onComplete: onComplete,
      builder: (context, value, child) {
        return Transform.translate(
          offset: offset(context, value),
          child: child,
        );
      },
      child: this,
    );
  }

  /// Adds a bounce animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.bounce(begin: 0.8, end: 1.2); // Bounces slightly
  /// ```
  GetAnimatedBuilder bounce({
    required double begin,
    required double end,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: begin, end: end),
      idleValue: begin,
      onComplete: onComplete,
      curve: Curves.bounceInOut,
      builder:
          (context, value, child) =>
              Transform.scale(scale: value, child: child),
      child: this,
    );
  }

  /// Adds a spin animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.spin(); // Spins the widget
  /// ```
  GetAnimatedBuilder spin({
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: 0, end: 1),
      idleValue: 0.0,
      onComplete: onComplete,
      builder:
          (context, value, child) =>
              Transform.rotate(angle: value * pi * 2, child: child),
      child: this,
    );
  }

  /// Adds a size animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.size(begin: 0.5, end: 1.0);
  /// ```
  GetAnimatedBuilder size({
    required double begin,
    required double end,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: begin, end: end),
      idleValue: begin,
      onComplete: onComplete,
      builder:
          (context, value, child) =>
              Transform.scale(scale: value, child: child),
      child: this,
    );
  }

  /// Adds a blur animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.blur(end: 10); // Apply a blur effect
  /// ```
  GetAnimatedBuilder blur({
    double begin = 0,
    double end = 15,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: begin, end: end),
      idleValue: begin,
      onComplete: onComplete,
      builder:
          (context, value, child) => BackdropFilter(
            filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
            child: child,
          ),
      child: this,
    );
  }

  /// Adds a flip animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.flip(); // Flips the widget
  /// ```
  GetAnimatedBuilder flip({
    double begin = 0,
    double end = 1,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: begin, end: end),
      idleValue: begin,
      onComplete: onComplete,
      builder:
          (context, value, child) => Transform(
            transform: Matrix4.rotationY(value * pi),
            alignment: Alignment.center,
            child: child,
          ),
      child: this,
    );
  }

  /// Adds a wave animation to the widget.
  ///
  /// Example:
  /// ```dart
  /// myWidget.wave(); // Applies a wave effect
  /// ```
  GetAnimatedBuilder wave({
    double begin = 0,
    double end = 1,
    Duration duration = _defaultDuration,
    Duration delay = _defaultDelay,
    ValueSetter<AnimationController>? onComplete,
    bool isSequential = false,
  }) {
    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: begin, end: end),
      idleValue: begin,
      onComplete: onComplete,
      builder:
          (context, value, child) => Transform(
            transform: Matrix4.translationValues(
              0.0,
              20.0 * sin(value * pi * 2),
              0.0,
            ),
            child: child,
          ),
      child: this,
    );
  }

  /// Calculates the appropriate delay for an animation.
  Duration _getDelay(bool isSequential, Duration delay) {
    // اصلاح assertion - باید delay صفر باشد وقتی isSequential true است
    assert(
      !(isSequential && delay != Duration.zero),
      "Error: When isSequential is true, delay must be Duration.zero (not specified)",
    );

    return isSequential
        ? (_currentAnimation?.totalDuration ?? Duration.zero)
        : delay;
  }
}
