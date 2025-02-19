import 'package:flutter/material.dart';

/// A generic animated builder that handles animation setup and disposal.
class GetAnimatedBuilder<T> extends StatefulWidget {
  final Duration duration;
  final Duration delay;
  final Widget child;
  final ValueSetter<AnimationController>? onComplete;
  final ValueSetter<AnimationController>? onStart; // Optional onStart callback
  final Tween<T> tween;
  final T idleValue; // Required idleValue
  final ValueWidgetBuilder<T> builder;
  final Curve curve;

  /// Total duration including initial delay
  Duration get totalDuration => duration + delay;

  const GetAnimatedBuilder({
    super.key,
    this.curve = Curves.linear,
    this.onComplete,
    this.onStart, // Include onStart in the constructor
    required this.duration,
    required this.tween,
    required this.idleValue, // idleValue is now required
    required this.builder,
    required this.child,
    required this.delay,
  });

  @override
  GetAnimatedBuilderState<T> createState() => GetAnimatedBuilderState<T>();
}

/// State class for GetAnimatedBuilder
class GetAnimatedBuilderState<T> extends State<GetAnimatedBuilder<T>>
    with TickerProviderStateMixin {
  late AnimationController _controller; // Remove 'final'
  Animation<T>? _animation; // Make nullable and remove 'late final'
  late T _idleValue; // Remove the dynamic type
  final bool _willResetOnDispose = false;
  bool wasStarted = false; // Define _wasStarted
  bool get willResetOnDispose => _willResetOnDispose;

  /// Handles animation status changes and callbacks
  void _listener(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        widget.onComplete?.call(_controller);
        if (_willResetOnDispose) {
          _controller.reset();
        }
        break;
      case AnimationStatus.forward:
        widget.onStart?.call(_controller);
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _idleValue = widget.idleValue; // Assign directly
    _initializeAnimation();
    Future.delayed(
      widget.delay,
      () {
        if (mounted) {
          _controller.forward();
          wasStarted = true;
        }
      },
    );
  }

  void _initializeAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _controller.addStatusListener(_listener);

    _animation = widget.tween.animate(
      CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant GetAnimatedBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.duration != widget.duration ||
        oldWidget.tween != widget.tween ||
        oldWidget.curve != widget.curve ||
        oldWidget.delay != widget.delay) {
      _controller.dispose(); // Dispose of the old controller
      _initializeAnimation(); // Re-initialize the animation

      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
          wasStarted = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.removeStatusListener(_listener);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _animation == null
        ? widget.builder(context, _idleValue, widget.child)
        : AnimatedBuilder(
            animation: _animation!,
            builder: (context, child) {
              final value = _animation!.value;
              return widget.builder(context, value, child);
            },
            child: widget.child,
          );
  }
}
