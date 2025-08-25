import 'package:flutter/material.dart';

/// A generic animated builder that handles animation setup and disposal.
///
/// The `GetAnimatedBuilder` widget provides a flexible way to create custom animations
/// for a child widget. It supports various animation properties including duration, delay,
/// tween, and callbacks for animation start and completion.
///
/// Example usage:
/// ```dart
/// GetAnimatedBuilder<double>(
///   duration: Duration(seconds: 2),
///   delay: Duration(seconds: 1),
///   tween: Tween<double>(begin: 50.0, end: 200.0),
///   idleValue: 50.0,
///   builder: (context, value, child) {
///     return Container(
///       width: value,
///       height: value,
///       color: Colors.blue,
///       child: Center(
///         child: Text(
///           'Animated Box',
///           style: TextStyle(color: Colors.white),
///         ),
///       ),
///     );
///   },
///   child: Container(),
///   onStart: (controller) {
///     print('Animation started');
///   },
///   onComplete: (controller) {
///     print('Animation completed');
///   },
/// ),
/// ```
class GetAnimatedBuilder<T> extends StatefulWidget {
  final Duration duration;
  final Duration delay;
  final Widget child;
  final ValueSetter<AnimationController>? onComplete;
  final ValueSetter<AnimationController>? onStart;
  final Tween<T> tween;
  final T idleValue;
  final ValueWidgetBuilder<T> builder;
  final Curve curve;

  /// Total duration including initial delay
  Duration get totalDuration => duration + delay;

  const GetAnimatedBuilder({
    super.key,
    this.curve = Curves.linear,
    this.onComplete,
    this.onStart,
    required this.duration,
    required this.tween,
    required this.idleValue,
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
  late AnimationController _controller;
  late Animation<T> _animation;
  late T _currentValue;
  bool _wasStarted = false;
  bool _isDisposed = false;

  /// Handles animation status changes and callbacks
  void _listener(AnimationStatus status) {
    if (_isDisposed) return;

    switch (status) {
      case AnimationStatus.forward:
        if (!_wasStarted) {
          _wasStarted = true;
          widget.onStart?.call(_controller);
        }
        break;
      case AnimationStatus.completed:
        widget.onComplete?.call(_controller);
        break;
      case AnimationStatus.dismissed:
      case AnimationStatus.reverse:
        break;
    }
  }

  /// Animation value listener to update current value
  void _valueListener() {
    if (_isDisposed) return;
    setState(() {
      _currentValue = _animation.value;
    });
  }

  @override
  void initState() {
    super.initState();
    _currentValue = widget.idleValue;
    _initializeAnimation();
    _startAnimationWithDelay();
  }

  void _initializeAnimation() {
    _controller = AnimationController(vsync: this, duration: widget.duration);

    _controller.addStatusListener(_listener);

    _animation = widget.tween.animate(
      CurvedAnimation(parent: _controller, curve: widget.curve),
    );

    _animation.addListener(_valueListener);
  }

  void _startAnimationWithDelay() {
    if (widget.delay.inMilliseconds > 0) {
      Future.delayed(widget.delay, () {
        if (mounted && !_isDisposed) {
          _controller.forward();
        }
      });
    } else {
      // Start immediately if no delay
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && !_isDisposed) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant GetAnimatedBuilder<T> oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if any critical properties changed
    final shouldReinitialize =
        oldWidget.duration != widget.duration ||
        oldWidget.tween != widget.tween ||
        oldWidget.curve != widget.curve ||
        oldWidget.delay != widget.delay;

    if (shouldReinitialize) {
      _disposeAnimation();
      _wasStarted = false;
      _currentValue = widget.idleValue;
      _initializeAnimation();
      _startAnimationWithDelay();
    }
  }

  void _disposeAnimation() {
    _animation.removeListener(_valueListener);
    _controller.removeStatusListener(_listener);
    _controller.dispose();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _disposeAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, _currentValue, widget.child);
  }
}
