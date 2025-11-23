import 'dart:async';

import '../../../get_core/src/get_interface.dart';

/// Extension methods for GetInterface to handle event loop operations.
extension LoopEventsExt on GetInterface {
  /// Schedules the computation to run at the end of the event loop.
  ///
  /// [computation] is the function to be executed.
  ///
  /// Example:
  /// ```dart
  /// GetInterface instance = Get.find();
  /// instance.toEnd(() async {
  ///   // Your async computation here
  /// });
  ///
  ///
  /// ```
  Future<T> toEnd<T>(FutureOr<T> Function() computation) async {
    await Future.delayed(Duration.zero);
    final val = computation();
    return val;
  }

  /// Schedules the computation to run as soon as possible, optionally based on a condition.
  ///
  /// [computation] is the function to be executed.
  /// [condition] is an optional function that returns a boolean to determine if the computation should be delayed.
  ///
  /// Example:
  /// ```dart
  /// GetInterface instance = Get.find();
  /// instance.asap(() {
  ///   // Your computation here
  /// }, condition: () => true);
  ///
  ///
  /// ```
  FutureOr<T> asap<T>(
    T Function() computation, {
    bool Function()? condition,
  }) async {
    T val;
    if (condition == null || !condition()) {
      await Future.delayed(Duration.zero);
      val = computation();
    } else {
      val = computation();
    }
    return val;
  }
}
