import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import 'get_animated_builder.dart';

typedef OffsetBuilder = Offset Function(BuildContext, double);

/// A versatile animation widget that simplifies creating various transitions.
class Animate extends StatelessWidget {
  /// The duration of the animation.
  final Duration duration;

  /// The delay before the animation starts. Defaults to zero.
  final Duration? delay;

  /// The widget to animate.
  final Widget child;

  /// A callback function that's called when the animation completes.
  /// It provides the AnimationController instance.
  final ValueSetter<AnimationController>? onComplete;

  /// The type of animation to apply.
  final AnimationType type;

  /// The starting value of the animation.
  final double begin;

  /// The ending value of the animation.
  final double end;

  /// The animation curve to use. Defaults to Curves.linear.
  final Curve curve;

  /// Creates an Animate widget.
  const Animate({
    super.key,
    required this.duration,
    this.delay,
    required this.child,
    this.onComplete,
    required this.type,
    this.begin = 0.0,
    this.end = 1.0,
    this.curve = Curves.linear,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveDelay = delay ?? Duration.zero;

    return GetAnimatedBuilder<double>(
      duration: duration,
      delay: effectiveDelay,
      tween: Tween<double>(begin: begin, end: end),
      curve: curve,
      idleValue: begin,
      builder: (context, value, child) {
        switch (type) {
          case AnimationType.fadeIn:
            return Opacity(opacity: value, child: child);
          case AnimationType.fadeOut:
            return Opacity(opacity: 1 - value, child: child);
          case AnimationType.rotate:
            return Transform.rotate(
              angle: value * pi * 2 * (end - begin),
              child: child,
            );
          case AnimationType.scale:
            return Transform.scale(
              scale: value * (end - begin) + begin,
              child: child,
            );
          case AnimationType.bounce:
            return Transform.scale(
              scale: 1 + value.abs() * (end - begin),
              child: child,
            );
          case AnimationType.spin:
            return Transform.rotate(
              angle: value * 360 * pi / 180.0,
              child: child,
            );
          case AnimationType.size:
            return Transform.scale(
              scale: value * (end - begin) + begin,
              child: child,
            );
          case AnimationType.blur:
            return BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: value * (end - begin),
                sigmaY: value * (end - begin),
              ),
              child: child,
            );
          case AnimationType.flip:
            return Transform(
              transform: Matrix4.rotationY(value * pi * (end - begin)),
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
                    ..rotateZ(sin(value * pi * 2) * 0.1 * (end - begin)),
              alignment: Alignment.center,
              child: child,
            );
          case AnimationType.slideInLeft:
            return Transform.translate(
              offset: Offset(
                value * MediaQuery.of(context).size.width * (end - begin),
                0,
              ),
              child: child,
            );
          case AnimationType.slideInRight:
            return Transform.translate(
              offset: Offset(
                (1 - value) * MediaQuery.of(context).size.width * (end - begin),
                0,
              ),
              child: child,
            );
          case AnimationType.slideInUp:
            return Transform.translate(
              offset: Offset(
                0,
                value * MediaQuery.of(context).size.height * (end - begin),
              ),
              child: child,
            );
          case AnimationType.slideInDown:
            return Transform.translate(
              offset: Offset(
                (1 - value) *
                    MediaQuery.of(context).size.height *
                    (end - begin),
                0,
              ),
              child: child,
            );
          case AnimationType.zoom:
            return Transform.scale(
              scale: lerpDouble(1, end, value)!,
              child: child,
            );
          case AnimationType.color:
            final beginColor =
                begin is Color ? begin as Color : Colors.transparent;
            final endColor = end is Color ? end as Color : Colors.transparent;
            return ColorFiltered(
              colorFilter: ColorFilter.mode(
                Color.lerp(beginColor, endColor, value)!,
                BlendMode.srcIn,
              ),
              child: child,
            );
        }
      },
      onComplete: onComplete,
      child: child,
    );
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
  zoom,
  color,
}
