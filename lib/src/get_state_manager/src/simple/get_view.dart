import 'package:flutter/widgets.dart';

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

/// ReactiveGetView is an enhanced version of GetView that provides automatic
/// reactive updates when observable variables in the controller change.
///
/// Unlike the standard GetView which is a StatelessWidget, ReactiveGetView
/// extends ObxWidget to automatically rebuild the UI when any observable
/// variables (.obs) in the controller are modified.
///
/// This eliminates the need to wrap parts of your UI in Obx() widgets
/// when using GetView, making the code cleaner and more intuitive.
///
/// Sample:
/// ```dart
/// class CounterController extends GetxController {
///   final count = 0.obs;
///   final name = 'Counter'.obs;
///
///   void increment() => count++;
///   void changeName(String newName) => name.value = newName;
/// }
///
/// class CounterView extends ReactiveGetView<CounterController> {
///   @override
///   Widget build(BuildContext context) {
///     return Scaffold(
///       appBar: AppBar(title: Text(controller.name.value)),
///       body: Center(
///         child: Text('Count: ${controller.count.value}'),
///       ),
///       floatingActionButton: FloatingActionButton(
///         onPressed: controller.increment,
///         child: Icon(Icons.add),
///       ),
///     );
///   }
/// }
/// ```
///
/// Key Benefits:
/// - Automatic reactive updates without wrapping in Obx()
/// - Cleaner code structure
/// - Better performance through intelligent rebuilding
/// - Maintains all GetView functionality
/// - Compatible with existing GetX controller patterns
abstract class ReactiveGetView<T> extends ObxWidget {
  const ReactiveGetView({super.key});

  /// Optional tag for controller retrieval
  /// Override this if you need to specify a tag for Get.find< T>(tag: tag)
  String? get tag => null;

  /// Set to true to use smartFind instead of regular find
  /// Default is false for backward compatibility
  bool get useSmartFind => false;

  /// Access to the controller instance
  /// This getter automatically finds and returns the controller
  /// while maintaining reactive capabilities
  T get controller {
    if (useSmartFind) {
      return GetInstance().smartFind<T>(tag: tag)!;
    } else {
      return GetInstance().find<T>(tag: tag)!;
    }
  }

  /// Override this method to build your reactive UI
  /// Note: ObxWidget.build() doesn't have BuildContext parameter
  Widget buildReactive(BuildContext context);

  @override
  Widget build() {
    // We get the context from the current build context
    return Builder(builder: (context) => buildReactive(context));
  }
}

/// Alternative implementation of ReactiveGetView that ensures proper reactive behavior
/// by wrapping the build method in an Obx widget internally
abstract class SafeReactiveGetView<T> extends StatelessWidget {
  const SafeReactiveGetView({super.key});

  /// Optional tag for controller retrieval
  String? get tag => null;

  /// Set to true to use smartFind instead of regular find
  /// Default is false for backward compatibility
  bool get useSmartFind => false;

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
