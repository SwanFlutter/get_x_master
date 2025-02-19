import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'animations.dart';
import 'get_animated_builder.dart';

const _defaultDuration = Duration(seconds: 2);
const _defaultDelay = Duration.zero;

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
    assert(isSequential || this is! GetAnimatedBuilder,
        'Can not use fadeOut + fadeIn when isSequential is false');

    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: 0.0, end: 1.0),
      idleValue: 0.0, // Add idleValue
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
    assert(isSequential || this is! GetAnimatedBuilder,
        'Cannot use fadeOut() + fadeIn() when isSequential is false');

    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(
          begin: 0.0, end: 1.0), // Fade from opaque to transparent
      idleValue: 1.0, // Add idleValue
      onComplete: onComplete,
      builder: (context, value, child) => Opacity(
          opacity: 1 - value, child: child), // Invert value for fade-out
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
      idleValue: begin, // Add idleValue
      onComplete: onComplete,
      builder: (context, value, child) => Transform.rotate(
        angle: value * pi * 2, // Convert turns to radians
        child: child,
      ),
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
      idleValue: begin, // Add idleValue
      onComplete: onComplete,
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
      child: this,
    );
  }

  /// Adds a slide animation to the widget.  The `offset` parameter is a function
  /// that takes the `BuildContext` and the animation value (0.0 to 1.0) and
  /// returns an `Offset`.
  ///
  /// Example:
  /// ```dart
  /// // Slide in from the left
  /// myWidget.slide(offset: (context, value) => Offset(-value, 0));
  ///
  /// // Slide in from the top, then slide out to the right, sequentially:
  /// myWidget
  ///   .slide(
  ///     offset: (context, value) => Offset(0, -value),
  ///     isSequential: true,
  ///   )
  ///   .slide(
  ///     offset: (context, value) => Offset(value, 0),
  ///     isSequential: true, // This one runs *after* the previous one completes.
  ///   );
  ///
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
    return GetAnimatedBuilder(
      duration: duration,
      delay: _getDelay(isSequential, delay),
      tween: Tween<double>(begin: begin, end: end),
      idleValue: begin, //Add idle value
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

  /// Adds a bounce animation to the widget.  This is similar to a scale animation,
  /// but with a bounce effect.
  ///
  /// Example:
  ///
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
      idleValue: begin, // Add idleValue
      onComplete: onComplete,
      curve: Curves.bounceInOut, // Use a bounce curve
      builder: (context, value, child) => Transform.scale(
        scale: value,
        child: child,
      ),
      child: this,
    );
  }

  /// Adds a spin animation (rotation) to the widget.  This is a convenience
  /// method for a full 360-degree rotation.
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
      idleValue: 0.0, // Add idleValue
      onComplete: onComplete,
      builder: (context, value, child) => Transform.rotate(
        angle: value * pi * 2,
        child: child,
      ),
      child: this,
    );
  }

  /// Adds a size animation to the widget. This effectively animates between two
  /// different sizes by scaling the widget.
  ///
  /// Example:
  ///
  /// ```dart
  /// // Animate from half size to full size
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
      idleValue: begin, // Add idleValue
      onComplete: onComplete,
      builder: (context, value, child) => Transform.scale(
        scale: value, // Use scale for size animation
        child: child,
      ),
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
      idleValue: begin, //add idle value
      onComplete: onComplete,
      builder: (context, value, child) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: value, sigmaY: value),
        child: child,
      ),
      child: this,
    );
  }

  /// Adds a flip animation to the widget. This creates a 3D flip effect.
  ///
  /// Example:
  ///
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
      idleValue: begin, // Add idleValue
      onComplete: onComplete,
      builder: (context, value, child) => Transform(
        transform: Matrix4.rotationY(value * pi), // Rotate around Y-axis
        alignment: Alignment.center, // Flip from the center
        child: child,
      ),
      child: this,
    );
  }

  /// Adds a wave animation to the widget.  This creates a vertical sinusoidal
  /// movement, like a wave.
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
      idleValue: begin, // Add idleValue
      onComplete: onComplete,
      builder: (context, value, child) => Transform(
        transform:
            Matrix4.translationValues(0.0, 20.0 * sin(value * pi * 2), 0.0),
        child: child,
      ),
      child: this,
    );
  }

  /// Calculates the appropriate delay for an animation.  If `isSequential` is
  /// true, it adds the duration of the previous animation (if any) to the
  /// provided delay.  If `isSequential` is false, it returns the provided
  /// delay directly.
  ///
  /// This method also asserts that if a delay is manually specified, sequential animation is not used
  ///
  ///
  /// It ensures that animations run one after another when `isSequential` is
  /// true, and that manually specified delays are respected when
  /// `isSequential` is false.
  Duration _getDelay(bool isSequential, Duration delay) {
    assert(!(isSequential && delay != Duration.zero),
        "Error: When isSequential is true, delay must be non-zero");

    return isSequential
        ? (_currentAnimation?.totalDuration ?? Duration.zero)
        : delay;
  }
}
