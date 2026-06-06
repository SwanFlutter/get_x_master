import 'package:flutter/material.dart';

import '../../../../get_x_master.dart';

/// Unlike GetXController, which serves to control events on each of its pages,
/// GetXService is not automatically disposed (nor can be removed with
/// Get.delete()).
/// It is ideal for situations where, once started, that service will
/// remain in memory, such as Auth control for example. Only way to remove
/// it is Get.reset().
abstract class GetXService extends DisposableInterface with GetxServiceMixin {}

abstract class DisposableInterface extends GetLifeCycle {
  /// Called immediately after the widget is allocated in memory.
  /// You might use this to initialize something for the controller.
  ///
  /// Override this method to perform any initialization logic for the
  /// controller, such as setting up listeners, fetching initial data,
  /// or initializing variables.
  ///
  /// Always call `super.onInit()` when overriding.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onInit() {
  ///   super.onInit();
  ///   fetchData();
  /// }
  /// ```
  @override
  @mustCallSuper
  void onInit() {
    super.onInit();

    Get.engine.addPostFrameCallback((_) => onReady());
  }

  /// Called 1 frame after [onInit]. It is the perfect place to enter
  /// navigation events, like snack bar, dialogs, or a new route, or
  /// async request.
  ///
  /// Override this method to run logic that requires the widget tree
  /// to be fully built (e.g. showing a dialog or navigating).
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onReady() {
  ///   super.onReady();
  ///   Get.snackbar('Welcome', 'Hello!');
  /// }
  /// ```
  @override
  void onReady() {
    super.onReady();
  }

  /// Called before the controller is removed from memory.
  ///
  /// Use this to dispose resources that could create memory leaks,
  /// such as [TextEditingController], [AnimationController],
  /// [StreamSubscription], or any active listeners.
  ///
  /// Always call `super.onClose()` when overriding.
  ///
  /// Example:
  /// ```dart
  /// @override
  /// void onClose() {
  ///   textController.dispose();
  ///   super.onClose();
  /// }
  /// ```
  @override
  void onClose() {
    super.onClose();
  }
}
