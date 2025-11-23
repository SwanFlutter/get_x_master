import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../get_x_master.dart';

/// Controller for managing and displaying GetSnack bars.
///
/// This class handles the queuing, display, and dismissal of snack bars
/// using the GetX library. It ensures that only one snack bar is shown
/// at a time and manages animations and transitions.
class SnackBarController {
  // Static queue to manage the order of snack bars.
  static final _snackBarQueue = _SnackBarQueue();

  /// Returns `true` if a snack bar is currently being shown.
  static bool get isSnackBarBeingShown => _snackBarQueue._isJobInProgress;

  /// Key for accessing the state of the GetSnackBar widget.
  final key = GlobalKey<GetSnackBarState>();

  /// Animation for the backdrop blur effect.
  late Animation<double> _filterBlurAnimation;

  /// Animation for the backdrop color overlay.
  late Animation<Color?> _filterColorAnimation;

  /// The GetSnackBar widget to be displayed.
  final GetSnackBar snackbar;

  /// Completer to signal when the snackbar transition is complete.
  final _transitionCompleter = Completer();

  /// Callback for snackbar status changes (OPENING, OPEN, CLOSING, CLOSED).
  late SnackbarStatusCallback? _snackbarStatus;

  /// Initial alignment of the snackbar during animation.
  late final Alignment? _initialAlignment;

  /// Final alignment of the snackbar during animation.
  late final Alignment? _endAlignment;

  /// Flag to indicate if the snackbar was dismissed by a swipe gesture.
  bool _wasDismissedBySwipe = false;

  /// Flag to indicate if the snackbar was dismissed by a tap.
  bool _onTappedDismiss = false;

  /// Timer to automatically dismiss the snackbar after a duration.
  Timer? _timer;

  /// The animation that drives the route's transition and the previous route's forward transition.
  late final Animation<Alignment> _animation;

  /// The animation controller that the route uses to drive the transitions.
  ///
  /// The animation itself is exposed by the [animation] property.
  late final AnimationController _controller;

  /// Current status of the snackbar.
  SnackbarStatus? _currentStatus;

  /// List of overlay entries used to display the snackbar.
  final _overlayEntries = <OverlayEntry>[];

  /// The overlay state where the snackbar is inserted.
  OverlayState? _overlayState;

  /// Constructor for the SnackbarController.
  SnackBarController(this.snackbar);

  /// Returns a future that completes when the snackbar transition is complete.
  Future<void> get future => _transitionCompleter.future;

  /// Closes the snackbar with or without animation.
  ///
  /// [withAnimations]: If true, plays the closing animation; otherwise,
  /// removes the snackbar immediately.
  Future<void> close({bool withAnimations = true}) async {
    if (!withAnimations) {
      _removeOverlay();
      return;
    }
    _removeEntry();
    await future;
  }

  /// Adds the GetSnackbar to a view queue. Only one GetSnackbar will be
  /// displayed at a time.
  ///
  /// Returns a future that completes when the snackbar disappears.
  Future<void> show() {
    return _snackBarQueue._addJob(this);
  }

  /// Cancels the timer that automatically dismisses the snackbar.
  void _cancelTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }
  }

  /// Configures the alignment of the snackbar based on its [SnackPosition].
  void _configureAlignment(SnackPosition snackPosition) {
    switch (snackbar.snackPosition) {
      case SnackPosition.TOP:
        _initialAlignment = const Alignment(-1.0, -2.0);
        _endAlignment = const Alignment(-1.0, -1.0);
        break;
      case SnackPosition.BOTTOM:
        _initialAlignment = const Alignment(-1.0, 2.0);
        _endAlignment = const Alignment(-1.0, 1.0);
        break;
    }
  }

  /// Configures the overlay entries and inserts them into the overlay.
  void _configureOverlay() {
    final overlayCtx = Get.overlayContext;
    if (overlayCtx == null) {
      throw Exception(
        'GetX overlay context is not available. Make sure you are using GetMaterialApp.',
      );
    }
    _overlayState = Overlay.of(overlayCtx);
    _overlayEntries.clear();
    _overlayEntries.addAll(_createOverlayEntries(_getBodyWidget()));
    _overlayState!.insertAll(_overlayEntries);
    _configureSnackBarDisplay();
  }

  /// Sets up the snackbar display, including animations and timer.
  void _configureSnackBarDisplay() {
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot configure a snackbar after disposing it.',
    );
    _controller = _createAnimationController();
    _configureAlignment(snackbar.snackPosition);
    _snackbarStatus = snackbar.snackbarStatus;
    _filterBlurAnimation = _createBlurFilterAnimation();
    _filterColorAnimation = _createColorOverlayColor();
    _animation = _createAnimation();
    _animation.addStatusListener(_handleStatusChanged);
    _configureTimer();
    _controller.forward();
  }

  /// Configures the timer to automatically dismiss the snackbar.
  void _configureTimer() {
    if (snackbar.duration != null) {
      if (_timer != null && _timer!.isActive) {
        _timer!.cancel();
      }
      _timer = Timer(snackbar.duration!, _removeEntry);
    } else {
      if (_timer != null) {
        _timer!.cancel();
      }
    }
  }

  /// Creates the animation for the snackbar's entry and exit transitions.
  Animation<Alignment> _createAnimation() {
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot create a animation from a disposed snackbar',
    );
    return AlignmentTween(begin: _initialAlignment, end: _endAlignment).animate(
      CurvedAnimation(
        parent: _controller,
        curve: snackbar.forwardAnimationCurve,
        reverseCurve: snackbar.reverseAnimationCurve,
      ),
    );
  }

  /// Creates the animation controller for the snackbar transitions.
  AnimationController _createAnimationController() {
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot create a animationController from a disposed snackbar',
    );
    assert(snackbar.animationDuration >= Duration.zero);
    return AnimationController(
      duration: snackbar.animationDuration,
      debugLabel: '$runtimeType',
      vsync: _overlayState!,
    );
  }

  /// Creates the animation for the backdrop blur effect.
  Animation<double> _createBlurFilterAnimation() {
    return Tween(begin: 0.0, end: snackbar.overlayBlur).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.35, curve: Curves.easeInOutCirc),
      ),
    );
  }

  /// Creates the animation for the backdrop color overlay.
  Animation<Color?> _createColorOverlayColor() {
    return ColorTween(
      begin: const Color(0x00000000),
      end: snackbar.overlayColor,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.35, curve: Curves.easeInOutCirc),
      ),
    );
  }

  /// Creates the overlay entries for the snackbar.
  ///
  /// [child]: The main content of the snackbar.
  Iterable<OverlayEntry> _createOverlayEntries(Widget child) {
    return <OverlayEntry>[
      // Overlay entry for the backdrop blur and color filter.
      if (snackbar.overlayBlur > 0.0) ...[
        OverlayEntry(
          builder: (context) => GestureDetector(
            onTap: () {
              // If the snackbar is dismissible and hasn't already been tapped,
              // close it on tap.
              if (snackbar.isDismissible && !_onTappedDismiss) {
                _onTappedDismiss = true;
                close();
              }
            },
            child: AnimatedBuilder(
              animation: _filterBlurAnimation,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: max(0.001, _filterBlurAnimation.value),
                    sigmaY: max(0.001, _filterBlurAnimation.value),
                  ),
                  child: Container(
                    constraints: const BoxConstraints.expand(),
                    color: _filterColorAnimation.value,
                  ),
                );
              },
            ),
          ),
          maintainState: false,
          opaque: false,
        ),
      ],
      // Overlay entry for the snackbar content.
      OverlayEntry(
        builder: (context) => Semantics(
          focused: false,
          container: true,
          explicitChildNodes: true,
          child: AlignTransition(
            alignment: _animation,
            child: snackbar.isDismissible
                ? _getDismissibleSnack(child)
                : _getSnackbarContainer(child),
          ),
        ),
        maintainState: false,
        opaque: false,
      ),
    ];
  }

  /// Builds the main content of the snackbar.
  Widget _getBodyWidget() {
    return Builder(
      builder: (_) {
        return GestureDetector(
          onTap: snackbar.onTap != null
              ? () => snackbar.onTap?.call(snackbar)
              : null,
          child: snackbar,
        );
      },
    );
  }

  /// Gets the default dismiss direction based on the snackbar position.
  DismissDirection _getDefaultDismissDirection() {
    if (snackbar.snackPosition == SnackPosition.TOP) {
      return DismissDirection.up;
    }
    return DismissDirection.down;
  }

  /// Wraps the snackbar content with a [Dismissible] widget.
  Widget _getDismissibleSnack(Widget child) {
    return Dismissible(
      direction: snackbar.dismissDirection ?? _getDefaultDismissDirection(),
      resizeDuration: null,
      confirmDismiss: (_) {
        // Prevent dismissal while the snackbar is opening or closing.
        if (_currentStatus == SnackbarStatus.OPENING ||
            _currentStatus == SnackbarStatus.CLOSING) {
          return Future.value(false);
        }
        return Future.value(true);
      },
      key: const Key('dismissible'),
      onDismissed: (_) {
        _wasDismissedBySwipe = true;
        _removeEntry();
      },
      child: _getSnackbarContainer(child),
    );
  }

  /// Returns the container for the snackbar content.
  Widget _getSnackbarContainer(Widget child) {
    return Container(margin: snackbar.margin, child: child);
  }

  /// Handles animation status changes.
  void _handleStatusChanged(AnimationStatus status) {
    switch (status) {
      case AnimationStatus.completed:
        _currentStatus = SnackbarStatus.OPEN;
        _snackbarStatus?.call(_currentStatus);
        if (_overlayEntries.isNotEmpty) _overlayEntries.first.opaque = false;
        break;
      case AnimationStatus.forward:
        _currentStatus = SnackbarStatus.OPENING;
        _snackbarStatus?.call(_currentStatus);
        break;
      case AnimationStatus.reverse:
        _currentStatus = SnackbarStatus.CLOSING;
        _snackbarStatus?.call(_currentStatus);
        if (_overlayEntries.isNotEmpty) _overlayEntries.first.opaque = false;
        break;
      case AnimationStatus.dismissed:
        assert(!_overlayEntries.first.opaque);
        _currentStatus = SnackbarStatus.CLOSED;
        _snackbarStatus?.call(_currentStatus);
        _removeOverlay();
        break;
    }
  }

  /// Removes the snackbar entry, triggering the closing animation.
  void _removeEntry() {
    assert(
      !_transitionCompleter.isCompleted,
      'Cannot remove entry from a disposed snackbar',
    );

    _cancelTimer();

    if (_wasDismissedBySwipe) {
      // Short delay before resetting the animation when dismissed by swipe.
      Timer(const Duration(milliseconds: 200), _controller.reset);
      _wasDismissedBySwipe = false;
    } else {
      // Reverse the animation to close the snackbar.
      _controller.reverse();
    }
  }

  /// Removes the snackbar overlay and disposes the animation controller.
  void _removeOverlay() {
    for (var element in _overlayEntries) {
      element.remove();
    }

    assert(
      !_transitionCompleter.isCompleted,
      'Cannot remove overlay from a disposed snackbar',
    );
    _controller.dispose();
    _overlayEntries.clear();
    _transitionCompleter.complete();
  }

  /// Shows the snackbar by configuring the overlay and returning the future.
  Future<void> _show() {
    _configureOverlay();
    return future;
  }

  /// Cancels all pending snackbars.
  static void cancelAllSnackbars() {
    _snackBarQueue._cancelAllJobs();
  }

  /// Closes the currently displayed snackbar.
  static Future<void> closeCurrentSnackbar() async {
    await _snackBarQueue._closeCurrentJob();
  }
}

/// A queue for managing the display of snackbars.
class _SnackBarQueue {
  final _queue = GetQueue();
  final _snackbarList = <SnackBarController>[];

  /// Returns the currently displayed snackbar, or null if none is displayed.
  SnackBarController? get _currentSnackbar {
    if (_snackbarList.isEmpty) return null;
    return _snackbarList.first;
  }

  /// Returns true if there is a snackbar being displayed or in the queue.
  bool get _isJobInProgress => _snackbarList.isNotEmpty;

  /// Adds a snackbar to the queue and displays it.
  Future<void> _addJob(SnackBarController job) async {
    _snackbarList.add(job);
    // Add job to the queue and remove after its shown
    final data = await _queue.add(job._show);
    _snackbarList.remove(job);
    return data;
  }

  /// Cancels all pending snackbars and clears the queue.
  Future<void> _cancelAllJobs() async {
    await _currentSnackbar?.close();
    _queue.cancelAllJobs();
    _snackbarList.clear();
  }

  /// Closes the currently displayed snackbar.
  Future<void> _closeCurrentJob() async {
    if (_currentSnackbar == null) return;
    await _currentSnackbar!.close();
  }
}
