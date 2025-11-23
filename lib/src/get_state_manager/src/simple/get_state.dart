/*import 'package:flutter/material.dart';

import '../../../get_instance/src/get_instance.dart';
import '../../get_state_manager.dart';
import '../rx_flutter/rx_disposable.dart';
import 'list_notifier.dart';

/// Complies with `GetStateUpdater`
///
/// This mixin's function represents a `GetStateUpdater`, and might be used
/// by `GetBuilder()`, `SimpleBuilder()` (or similar) to comply
/// with [GetStateUpdate] signature. REPLACING the [StateSetter].
/// Avoids the potential (but extremely unlikely) issue of having
/// the Widget in a dispose() state, and abstracts the
/// API from the ugly fn((){}).
mixin GetStateUpdaterMixin<T extends StatefulWidget> on State<T> {
  // To avoid the creation of an antonym function to be GC later.
  // ignore: prefer_function_declarations_over_variables

  /// Experimental method to replace setState((){});
  /// Used with GetStateUpdate.
  void getUpdate() {
    if (mounted) setState(() {});
  }
}

typedef GetControllerBuilder<T extends DisposableInterface> =
    Widget Function(T controller);

// class _InheritedGetxController<T extends GetxController>
//     extends InheritedWidget {
//   final T model;
//   final int version;

//   _InheritedGetxController({
//     Key key,
//     @required Widget child,
//     @required this.model,
//   })  : version = model.notifierVersion,
//         super(key: key, child: child);

//   @override
//   bool updateShouldNotify(_InheritedGetxController<T> oldWidget) =>
//       (oldWidget.version != version);
// }

// extension WatchEtx on GetxController {
//   T watch<T extends GetxController>() {
//     final instance = Get.find<T>();
//     _GetBuilderState._currentState.watch(instance.update);
//     return instance;
//   }
// }

class GetBuilder<T extends GetXController> extends StatefulWidget {
  final GetControllerBuilder<T> builder;
  final bool global;
  final Object? id;
  final String? tag;
  final bool autoRemove;
  final bool assignId;
  final Object Function(T value)? filter;
  final void Function(GetBuilderState<T> state)? initState,
      dispose,
      didChangeDependencies;
  final void Function(GetBuilder oldWidget, GetBuilderState<T> state)?
  didUpdateWidget;
  final T? init;

  const GetBuilder({
    super.key,
    this.init,
    this.global = true,
    required this.builder,
    this.autoRemove = true,
    this.assignId = false,
    this.initState,
    this.filter,
    this.tag,
    this.dispose,
    this.id,
    this.didChangeDependencies,
    this.didUpdateWidget,
  });

  // static T of<T extends GetxController>(
  //   BuildContext context, {
  //   bool rebuild = false,
  // }) {
  //   var widget = rebuild
  //       ? context
  //       .dependOnInheritedWidgetOfExactType<_InheritedGetxController<T>>()
  //       : context
  //           .getElementForInheritedWidgetOfExactType<
  //               _InheritedGetxController<T>>()
  //           ?.widget;

  //   if (widget == null) {
  //     throw 'Error: Could not find the correct dependency.';
  //   } else {
  //     return (widget as _InheritedGetxController<T>).model;
  //   }
  // }

  @override
  GetBuilderState<T> createState() => GetBuilderState<T>();
}

class GetBuilderState<T extends GetXController> extends State<GetBuilder<T>>
    with GetStateUpdaterMixin {
  T? controller;
  bool? _isCreator = false;
  VoidCallback? _remove;
  Object? _filter;

  @override
  void initState() {
    // _GetBuilderState._currentState = this;
    super.initState();
    widget.initState?.call(this);

    var isRegistered = GetInstance().isRegistered<T>(tag: widget.tag);

    if (widget.global) {
      if (isRegistered) {
        if (GetInstance().isPrepared<T>(tag: widget.tag)) {
          _isCreator = true;
        } else {
          _isCreator = false;
        }
        controller = GetInstance().find<T>(tag: widget.tag);
      } else {
        controller = widget.init;
        _isCreator = true;
        GetInstance().put<T>(controller!, tag: widget.tag);
      }
    } else {
      controller = widget.init;
      _isCreator = true;
      controller?.onStart();
    }

    if (widget.filter != null) {
      _filter = widget.filter!(controller!);
    }

    _subscribeToController();
  }

  /// Register to listen Controller's events.
  /// It gets a reference to the remove() callback, to delete the
  /// setState "link" from the Controller.
  void _subscribeToController() {
    _remove?.call();
    _remove =
        (widget.id == null)
            ? controller?.addListener(
              _filter != null ? _filterUpdate : getUpdate,
            )
            : controller?.addListenerId(
              widget.id,
              _filter != null ? _filterUpdate : getUpdate,
            );
  }

  void _filterUpdate() {
    var newFilter = widget.filter!(controller!);
    if (newFilter != _filter) {
      _filter = newFilter;
      getUpdate();
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose?.call(this);
    if (_isCreator! || widget.assignId) {
      if (widget.autoRemove && GetInstance().isRegistered<T>(tag: widget.tag)) {
        GetInstance().delete<T>(tag: widget.tag);
      }
    }

    _remove?.call();

    controller = null;
    _isCreator = null;
    _remove = null;
    _filter = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call(this);
  }

  @override
  void didUpdateWidget(GetBuilder oldWidget) {
    super.didUpdateWidget(oldWidget as GetBuilder<T>);
    // to avoid conflicts when modifying a "grouped" id list.
    if (oldWidget.id != widget.id) {
      _subscribeToController();
    }
    widget.didUpdateWidget?.call(oldWidget, this);
  }

  @override
  Widget build(BuildContext context) {
    // return _InheritedGetxController<T>(
    //   model: controller,
    //   child: widget.builder(controller),
    // );
    return widget.builder(controller!);
  }
}

// extension FindExt on BuildContext {
//   T find<T extends GetxController>() {
//     return GetBuilder.of<T>(this, rebuild: false);
//   }
// }

// extension ObserverEtx on BuildContext {
//   T obs<T extends GetxController>() {
//     return GetBuilder.of<T>(this, rebuild: true);
//   }
// }
*/

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../get_instance/src/get_instance.dart';
import '../../../get_rx/src/rx_types/rx_types.dart';
import '../../get_state_manager.dart';
import '../rx_flutter/rx_disposable.dart';
import 'list_notifier.dart';

/// Complies with `GetStateUpdater`
///
/// This mixin's function represents a `GetStateUpdater`, and might be used
/// by `GetBuilder()`, `SimpleBuilder()` (or similar) to comply
/// with [GetStateUpdate] signature. REPLACING the [StateSetter].
/// Avoids the potential (but extremely unlikely) issue of having
/// the Widget in a dispose() state, and abstracts the
/// API from the ugly fn((){}).
mixin GetStateUpdaterMixin<T extends StatefulWidget> on State<T> {
  // To avoid the creation of an antonym function to be GC later.
  // ignore: prefer_function_declarations_over_variables

  /// Experimental method to replace setState((){});
  /// Used with GetStateUpdate.
  void getUpdate() {
    if (mounted) setState(() {});
  }
}

typedef GetControllerBuilder<T extends DisposableInterface> =
    Widget Function(T controller);

class GetBuilder<T extends GetXController> extends StatefulWidget {
  final GetControllerBuilder<T> builder;
  final bool global;
  final Object? id;
  final String? tag;
  final bool autoRemove;
  final bool assignId;
  final Object Function(T value)? filter;
  final void Function(GetBuilderState<T> state)? initState,
      dispose,
      didChangeDependencies;
  final void Function(GetBuilder oldWidget, GetBuilderState<T> state)?
  didUpdateWidget;
  final T? init;

  const GetBuilder({
    super.key,
    this.init,
    this.global = true,
    required this.builder,
    this.autoRemove = true,
    this.assignId = false,
    this.initState,
    this.filter,
    this.tag,
    this.dispose,
    this.id,
    this.didChangeDependencies,
    this.didUpdateWidget,
  });

  @override
  GetBuilderState<T> createState() => GetBuilderState<T>();
}

class GetBuilderState<T extends GetXController> extends State<GetBuilder<T>>
    with GetStateUpdaterMixin {
  T? controller;
  bool? _isCreator = false;
  VoidCallback? _remove;
  Object? _filter;

  @override
  void initState() {
    super.initState();
    widget.initState?.call(this);
    _initializeController();
  }

  /// Safe controller initialization with null checks and smart dependency management
  void _initializeController() {
    try {
      final isRegistered = GetInstance().isRegistered<T>(tag: widget.tag);

      if (widget.global) {
        if (isRegistered) {
          // Check if the instance is prepared (lazy initialization)
          if (GetInstance().isPrepared<T>(tag: widget.tag)) {
            _isCreator = true;
          } else {
            _isCreator = false;
          }

          // Safely find the controller
          try {
            controller = GetInstance().find<T>(tag: widget.tag);
          } catch (e) {
            // If find fails and we have an init controller, use it
            if (widget.init != null) {
              controller = widget.init;
              _isCreator = true;
              _safelyPutController();
            } else {
              // Try smart initialization if available
              _trySmartInitialization();
            }
          }
        } else {
          // No registered instance found
          if (widget.init != null) {
            controller = widget.init;
            _isCreator = true;
            _safelyPutController();
          } else {
            _trySmartInitialization();
          }
        }
      } else {
        // Local controller management
        controller = widget.init;
        _isCreator = true;
        controller?.onStart();
      }

      // Setup filter if provided
      if (widget.filter != null && controller != null) {
        _filter = widget.filter!(controller!);
      }

      // Subscribe to controller updates
      _subscribeToController();
    } catch (e) {
      // Enhanced error handling
      debugPrint('GetBuilder initialization error: $e');
      _handleInitializationError(e);
    }
  }

  /// Safely put controller with null checks
  void _safelyPutController() {
    if (controller != null) {
      try {
        GetInstance().put<T>(controller!, tag: widget.tag);
      } catch (e) {
        debugPrint('Error putting controller: $e');
        // Fallback: try with smartLazyPut if available
        _tryAlternativePutMethods();
      }
    }
  }

  /// Try alternative put methods for better compatibility
  void _tryAlternativePutMethods() {
    if (controller == null) return;

    try {
      // Try smartLazyPut if the extension is available
      GetInstance().smartLazyPut<T>(() => controller!, tag: widget.tag);
    } catch (e) {
      try {
        // Fallback to regular lazyPut
        GetInstance().lazyPut<T>(() => controller!, tag: widget.tag);
      } catch (e2) {
        debugPrint('All put methods failed: $e2');
      }
    }
  }

  /// Try smart initialization methods
  void _trySmartInitialization() {
    try {
      // First try to find if controller is already registered
      if (GetInstance().isRegistered<T>(tag: widget.tag)) {
        controller = GetInstance().find<T>(tag: widget.tag);
        _isCreator = false;
        return;
      }

      // If not registered, try smartFind which might create from prepared builder
      try {
        controller = GetInstance().smartFind<T>(tag: widget.tag);
        _isCreator = false;
      } catch (smartFindError) {
        // smartFind failed, try to use init controller if available
        if (widget.init != null) {
          controller = widget.init;
          _isCreator = true;
          _safelyPutController();
        } else {
          // No init controller provided, throw descriptive error
          throw Exception(
            'No controller available for type $T${widget.tag != null ? ' with tag ${widget.tag}' : ''}. '
            'Please ensure the controller is registered using Get.put(), Get.lazyPut(), or Get.smartLazyPut(), '
            'or provide an init controller to GetBuilder.',
          );
        }
      }
    } catch (e) {
      // Final fallback: try to use init controller
      if (widget.init != null) {
        controller = widget.init;
        _isCreator = true;
        _safelyPutController();
      } else {
        rethrow;
      }
    }
  }

  /// Handle initialization errors gracefully
  void _handleInitializationError(dynamic error) {
    debugPrint('GetBuilder<$T> initialization failed: $error');

    // Try to recover with init controller
    if (widget.init != null) {
      try {
        controller = widget.init;
        _isCreator = true;
        _safelyPutController();
        _subscribeToController();
        debugPrint('GetBuilder<$T> recovered using init controller');
      } catch (recoveryError) {
        debugPrint('GetBuilder<$T> recovery failed: $recoveryError');
        throw Exception(
          'GetBuilder<$T> failed to initialize and recovery failed. '
          'Original error: $error. '
          'Recovery error: $recoveryError. '
          'Please check your controller implementation and registration.',
        );
      }
    } else {
      // Provide more helpful error message
      throw Exception(
        'GetBuilder<$T> failed to initialize. '
        'Error: $error. '
        'Solutions: '
        '1. Register the controller using Get.put<$T>(${T.toString()}()) '
        '2. Use Get.lazyPut<$T>(() => ${T.toString()}()) '
        '3. Use Get.smartLazyPut<$T>(() => ${T.toString()}()) '
        '4. Provide an init controller: GetBuilder<$T>(init: ${T.toString()}(), builder: ...)',
      );
    }
  }

  /// Register to listen Controller's events.
  /// It gets a reference to the remove() callback, to delete the
  /// setState "link" from the Controller.
  void _subscribeToController() {
    if (controller == null) return;

    _remove?.call();

    try {
      _remove = (widget.id == null)
          ? controller?.addListener(_filter != null ? _filterUpdate : getUpdate)
          : controller?.addListenerId(
              widget.id,
              _filter != null ? _filterUpdate : getUpdate,
            );
    } catch (e) {
      debugPrint('Error subscribing to controller: $e');
    }
  }

  void _filterUpdate() {
    if (controller == null || widget.filter == null) return;

    try {
      var newFilter = widget.filter!(controller!);
      if (newFilter != _filter) {
        _filter = newFilter;
        getUpdate();
      }
    } catch (e) {
      debugPrint('Filter update error: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose?.call(this);

    // Safe disposal with null checks
    try {
      if (_isCreator == true || widget.assignId) {
        if (widget.autoRemove &&
            GetInstance().isRegistered<T>(tag: widget.tag)) {
          GetInstance().delete<T>(tag: widget.tag);
        }
      }
    } catch (e) {
      debugPrint('Error during controller disposal: $e');
    }

    // Clean up listeners
    try {
      _remove?.call();
    } catch (e) {
      debugPrint('Error removing listener: $e');
    }

    // Reset all references
    controller = null;
    _isCreator = null;
    _remove = null;
    _filter = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    widget.didChangeDependencies?.call(this);
  }

  @override
  void didUpdateWidget(GetBuilder oldWidget) {
    super.didUpdateWidget(oldWidget as GetBuilder<T>);

    // Re-subscribe if id changed to avoid conflicts when modifying a "grouped" id list.
    if (oldWidget.id != widget.id) {
      _subscribeToController();
    }

    widget.didUpdateWidget?.call(oldWidget, this);
  }

  @override
  Widget build(BuildContext context) {
    // Safe build with null check
    if (controller == null) {
      // Try to recover the controller before building
      try {
        _initializeController();
      } catch (e) {
        debugPrint('Failed to recover controller in build: $e');

        // Show user-friendly error widget in debug mode
        if (kDebugMode) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Controller Error',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Type: $T',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  if (widget.tag != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      'Tag: ${widget.tag}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        e.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          // In release mode, show minimal error
          return const Center(child: Text('Service temporarily unavailable'));
        }
      }
    }

    // Final null check before building
    if (controller == null) {
      return const Center(child: Text('Controller not available'));
    }

    return widget.builder(controller!);
  }
}

/// Enhanced GetBuilder that can observe multiple reactive variables
/// Combines the power of GetBuilder with Obx-like reactive capabilities
class GetBuilderObs<T extends GetXController> extends StatefulWidget {
  final Widget Function(T controller) builder;
  final List<RxInterface> observables;
  final T? init;
  final String? tag;
  final bool global;
  final bool autoRemove;
  final Object? id;
  final Object Function(T value)? filter;
  final void Function(GetBuilderObsState<T> state)? initState;
  final void Function(GetBuilderObsState<T> state)? dispose;

  const GetBuilderObs({
    super.key,
    required this.builder,
    this.observables = const [],
    this.init,
    this.tag,
    this.global = true,
    this.autoRemove = true,
    this.id,
    this.filter,
    this.initState,
    this.dispose,
  });

  @override
  GetBuilderObsState<T> createState() => GetBuilderObsState<T>();
}

class GetBuilderObsState<T extends GetXController>
    extends State<GetBuilderObs<T>>
    with GetStateUpdaterMixin {
  T? controller;
  bool? _isCreator = false;
  VoidCallback? _remove;
  Object? _filter;
  final List<StreamSubscription> _subscriptions = [];
  final RxNotifier _observer = RxNotifier();
  late StreamSubscription _obsSubs;

  @override
  void initState() {
    super.initState();
    widget.initState?.call(this);
    _initializeController();
    _setupObservables();
  }

  void _initializeController() {
    try {
      final isRegistered = GetInstance().isRegistered<T>(tag: widget.tag);

      if (widget.global) {
        if (isRegistered) {
          if (GetInstance().isPrepared<T>(tag: widget.tag)) {
            _isCreator = true;
          } else {
            _isCreator = false;
          }
          controller = GetInstance().find<T>(tag: widget.tag);
        } else {
          if (widget.init != null) {
            controller = widget.init;
            _isCreator = true;
            GetInstance().put<T>(controller!, tag: widget.tag);
          } else {
            throw Exception(
              'No controller available for type $T${widget.tag != null ? ' with tag ${widget.tag}' : ''}. '
              'Please provide an init controller or register it using Get.put(), Get.lazyPut(), or Get.smartLazyPut().',
            );
          }
        }
      } else {
        controller = widget.init;
        _isCreator = true;
        controller?.onStart();
      }

      if (widget.filter != null && controller != null) {
        _filter = widget.filter!(controller!);
      }

      _subscribeToController();
    } catch (e) {
      debugPrint('GetBuilderObs initialization error: $e');
      rethrow;
    }
  }

  void _setupObservables() {
    // Setup observer for reactive variables
    _obsSubs = _observer.listen((_) {
      if (mounted) setState(() {});
    }, cancelOnError: false);

    // Subscribe to each observable
    for (final observable in widget.observables) {
      _subscriptions.add(
        observable.listen((_) {
          if (mounted) setState(() {});
        }),
      );
    }
  }

  void _subscribeToController() {
    if (controller == null) return;

    _remove?.call();

    try {
      _remove = (widget.id == null)
          ? controller?.addListener(_filter != null ? _filterUpdate : getUpdate)
          : controller?.addListenerId(
              widget.id,
              _filter != null ? _filterUpdate : getUpdate,
            );
    } catch (e) {
      debugPrint('Error subscribing to controller: $e');
    }
  }

  void _filterUpdate() {
    if (controller == null || widget.filter == null) return;

    try {
      var newFilter = widget.filter!(controller!);
      if (newFilter != _filter) {
        _filter = newFilter;
        getUpdate();
      }
    } catch (e) {
      debugPrint('Filter update error: $e');
    }
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose?.call(this);

    // Clean up controller
    try {
      if (_isCreator == true) {
        if (widget.autoRemove &&
            GetInstance().isRegistered<T>(tag: widget.tag)) {
          GetInstance().delete<T>(tag: widget.tag);
        }
      }
    } catch (e) {
      debugPrint('Error during controller disposal: $e');
    }

    // Clean up listeners
    try {
      _remove?.call();
      _obsSubs.cancel();
      _observer.close();
      for (final subscription in _subscriptions) {
        subscription.cancel();
      }
    } catch (e) {
      debugPrint('Error removing listeners: $e');
    }

    // Reset references
    controller = null;
    _isCreator = null;
    _remove = null;
    _filter = null;
    _subscriptions.clear();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      if (kDebugMode) {
        return const Center(
          child: Text('Controller not available in GetBuilderObs'),
        );
      } else {
        return const SizedBox.shrink();
      }
    }

    // Use RxInterface.notifyChildren to track reactive variables
    return RxInterface.notifyChildren(
      _observer,
      () => widget.builder(controller!),
    );
  }
}

/// GetX-specific BuildContext extensions
extension GetXControllerExtensions on BuildContext {
  /// Find a controller without rebuilding the widget
  T find<T extends GetXController>({String? tag}) {
    return GetInstance().find<T>(tag: tag);
  }

  /// Find a controller safely, returns null if not found
  T? findOrNull<T extends GetXController>({String? tag}) {
    try {
      return GetInstance().find<T>(tag: tag);
    } catch (e) {
      return null;
    }
  }

  /// Get controller and observe it for changes (rebuilds widget)
  /// Note: This should be used within an Obx or GetX widget to work properly
  T obs<T extends GetXController>({String? tag}) {
    final controller = GetInstance().find<T>(tag: tag);
    return controller;
  }

  /// Check if a controller is registered
  bool isControllerRegistered<T extends GetXController>({String? tag}) {
    return GetInstance().isRegistered<T>(tag: tag);
  }

  /// Show a simple snackbar
  void showSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  /// Navigate to a page
  Future<T?> push<T>(Widget page) {
    return Navigator.of(this).push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// Go back
  void pop<T>([T? result]) {
    Navigator.of(this).pop<T>(result);
  }
}

/// Multi-observable builder that can watch multiple reactive variables
class MultiObx extends StatefulWidget {
  final Widget Function() builder;
  final List<RxInterface> observables;

  const MultiObx({super.key, required this.builder, required this.observables});

  @override
  MultiObxState createState() => MultiObxState();
}

class MultiObxState extends State<MultiObx> {
  final List<StreamSubscription> _subscriptions = [];

  @override
  void initState() {
    super.initState();
    _setupObservables();
  }

  void _setupObservables() {
    for (final observable in widget.observables) {
      _subscriptions.add(
        observable.listen((_) {
          if (mounted) setState(() {});
        }),
      );
    }
  }

  @override
  void dispose() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
    _subscriptions.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder();
  }
}

/// Enhanced GetInstance extensions for better compatibility
extension SafeGetInstance on GetInstance {
  /// Safe version of put that handles null values
  S safePut<S>(
    S? dependency, {
    String? tag,
    bool permanent = false,
    InstanceBuilderCallback<S>? builder,
  }) {
    if (dependency == null) {
      if (builder != null) {
        dependency = builder();
      } else {
        throw ArgumentError('Both dependency and builder cannot be null');
      }
    }
    return put<S>(dependency as S, tag: tag, permanent: permanent);
  }

  /// Safe version of find with fallback
  S? safeFindOrNull<S>({String? tag}) {
    try {
      return find<S>(tag: tag);
    } catch (e) {
      return null;
    }
  }

  /// Enhanced smart put with better error handling
  S enhancedSmartPut<S>({
    required InstanceBuilderCallback<S> builder,
    bool Function()? condition,
    bool Function(S instance)? validityCheck,
    String? tag,
    bool permanent = false,
    bool fenix = false,
    S? fallback,
  }) {
    try {
      // Check if instance is already registered
      if (isRegistered<S>(tag: tag)) {
        final existingInstance = safeFindOrNull<S>(tag: tag);

        if (existingInstance != null) {
          // Validate existing instance if a validity check is provided
          if (validityCheck != null && !validityCheck(existingInstance)) {
            // Delete invalid instance
            delete<S>(tag: tag, force: true);
          } else {
            // Return existing valid instance
            return existingInstance;
          }
        }
      }

      // Check creation condition if provided
      if (condition != null && !condition()) {
        if (fallback != null) {
          return safePut(fallback, tag: tag, permanent: permanent);
        }
        throw ArgumentError('Instance creation condition not met for $S');
      }

      // Create new instance
      final instance = builder();

      // Register instance based on fenix flag
      if (fenix) {
        smartLazyPut(() => instance, tag: tag, fenix: true);
      } else {
        safePut(instance, tag: tag, permanent: permanent);
      }

      return instance;
    } catch (e) {
      // Return fallback if available
      if (fallback != null) {
        return safePut(fallback, tag: tag, permanent: permanent);
      }
      rethrow;
    }
  }
}
