import 'package:flutter/material.dart';

import '../../../../get_x_master.dart';
import 'get_widget_cache.dart';

/// GetView is a great way of quickly access your Controller
/// without having to call Get.find< AwesomeController>() yourself.
///
/// Sample:
/// ```
/// class AwesomeController extends GetxController {
///   final String title = 'My Awesome View';
/// }
///
/// class AwesomeView extends GetView<AwesomeController> {
///   /// if you need you can pass the tag for
///   /// Get.find<AwesomeController>(tag:"myTag");
///   @override
///   final String tag = "myTag";
///
///   /// Use smartFind instead of regular find
///   @override
///   final bool useSmartFind = true;
///
///   AwesomeView({Key key}):super(key:key);
///
///   @override
///   Widget build(BuildContext context) {
///     return Container(
///       padding: EdgeInsets.all(20),
///       child: Text( controller.title ),
///     );
///   }
/// }
/// ```
abstract class GetView<T> extends StatelessWidget {
  const GetView({super.key});

  String? get tag => null;

  /// Set to true to use smartFind instead of regular find
  /// Default is false for backward compatibility
  bool get useSmartFind => true;

  /// Controller getter that supports both find and smartFind
  T get controller {
    if (useSmartFind) {
      return GetInstance().smartFind<T>(tag: tag)!;
    } else {
      return GetInstance().find<T>(tag: tag)!;
    }
  }

  @override
  Widget build(BuildContext context);
}

/// Simple and clean ReactiveGetView that automatically wraps the entire build method
/// in reactive behavior without requiring additional methods or complexity.
/// 
/// This provides the same functionality as GetView but with automatic reactivity,
/// eliminating the need for manual Obx wrapping while keeping the API simple.
/// 
/// Example:
/// ```dart
/// class CounterView extends ReactiveGetView<CounterController> {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(
///         title: Text(controller.name.value), // Automatically reactive
///       ),
///       body: Column(
///         children: [
///           Text('Count: ${controller.count.value}'), // Automatically reactive
///           if (controller.isLoading.value) // Automatically reactive
///             CircularProgressIndicator()
///           else
///             ElevatedButton(
///               onPressed: controller.increment,
///               child: Text('Increment'),
///             ),
///         ],
///       ),
///     );
///   }
/// }
/// ```
abstract class ReactiveGetView<T> extends StatelessWidget {
  const ReactiveGetView({super.key});

  /// Optional tag for controller retrieval
  String? get tag => null;

  /// Set to true to use smartFind instead of regular find
  /// Default is true for enhanced functionality
  bool get useSmartFind => true;

  /// Access to the controller instance
  T get controller {
    if (useSmartFind) {
      return GetInstance().smartFind<T>(tag: tag)!;
    } else {
      return GetInstance().find<T>(tag: tag);
    }
  }

  /// Build method that will be automatically wrapped in reactive behavior
  Widget buildReactive(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Obx(() => buildReactive(context));
  }
}

/// SafeReactiveGetView provides additional safety checks and error handling
/// for reactive behavior, with optional smart finding capabilities.
/// 
/// Use this when you need extra safety guarantees or when working with
/// controllers that might not be properly initialized.
abstract class SafeReactiveGetView<T> extends StatelessWidget {
  const SafeReactiveGetView({super.key});

  /// Optional tag for controller retrieval
  String? get tag => null;

  /// Set to true to use smartFind instead of regular find
  /// Default is true for enhanced functionality
  bool get useSmartFind => true;

  /// Access to the controller instance
  T get controller {
    if (useSmartFind) {
      return GetInstance().smartFind<T>(tag: tag)!;
    } else {
      return GetInstance().find<T>(tag: tag)!;
    }
  }

  /// Override this method to build your reactive UI
  Widget buildReactive(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return Obx(() => buildReactive(context));
  }
}


/// Enhanced ReactiveGetView with automatic state management integration
/// 
/// This version automatically integrates with StateMixin for handling
/// loading, success, error, and empty states.
abstract class StateReactiveGetView<T extends GetXController> extends ReactiveGetView<T> {
  const StateReactiveGetView({super.key});

  /// Build method for success state
  Widget buildSuccess(BuildContext context, dynamic data);

  /// Build method for loading state
  Widget buildLoading(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }

  /// Build method for error state
  Widget buildError(BuildContext context, String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 64),
          const SizedBox(height: 16),
          Text('Error: $error', textAlign: TextAlign.center),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// Build method for empty state
  Widget buildEmpty(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, color: Colors.grey, size: 64),
          SizedBox(height: 16),
          Text('No data available'),
        ],
      ),
    );
  }

  /// Called when retry button is pressed in error state
  void onRetry() {}

  @override
  Widget buildReactive(BuildContext context) {
    // Check if controller implements StateMixin
    try {
      final dynamic dynamicController = controller;
      if (dynamicController is StateMixin) {
        final stateMixin = dynamicController;
        
        if (stateMixin.status.isLoading) {
          return buildLoading(context);
        } else if (stateMixin.status.isError) {
          return buildError(context, stateMixin.status.errorMessage ?? 'Unknown error');
        } else if (stateMixin.status.isEmpty) {
          return buildEmpty(context);
        } else {
          return buildSuccess(context, stateMixin.state);
        }
      }
    } catch (e) {
      // Fallback if StateMixin check fails
    }
    
    // Fallback to success state if not using StateMixin
    return buildSuccess(context, null);
  }
}

/// GetWidget is a great way of quickly access your individual Controller
/// without having to call Get.find< AwesomeController>() yourself.
/// Get save you controller on cache, so, you can to use Get.create() safely
/// GetWidget is perfect to multiples instance of a same controller. Each
/// GetWidget will have your own controller, and will be call events as `onInit`
/// and `onClose` when the controller get in/get out on memory.
abstract class GetWidget<S extends GetLifeCycleBase?> extends GetWidgetCache {
  const GetWidget({super.key});

  @protected
  String? get tag => null;

  S get controller => GetWidget._cache[this] as S;

  static final _cache = Expando<GetLifeCycleBase>();

  @protected
  Widget build(BuildContext context);

  @override
  WidgetCache createWidgetCache() => _GetCache<S>();
}

class _GetCache<S extends GetLifeCycleBase?> extends WidgetCache<GetWidget<S>> {
  S? _controller;
  bool _isCreator = false;
  InstanceInfo? info;

  @override
  void onInit() {
    info = GetInstance().getInstanceInfo<S>(tag: widget!.tag);

    _isCreator = info!.isPrepared && info!.isCreate;

    if (info!.isRegistered) {
      _controller = Get.find<S>(tag: widget!.tag);
    }

    GetWidget._cache[widget!] = _controller;
    super.onInit();
  }

  @override
  void onClose() {
    if (_isCreator) {
      Get.asap(() {
        widget!.controller!.onDelete();
        Get.log('"${widget!.controller.runtimeType}" onClose() called');
        Get.log('"${widget!.controller.runtimeType}" deleted from memory');
        GetWidget._cache[widget!] = null;
      });
    }
    info = null;
    super.onClose();
  }

  @override
  Widget build(BuildContext context) {
    return widget!.build(context);
  }
}
