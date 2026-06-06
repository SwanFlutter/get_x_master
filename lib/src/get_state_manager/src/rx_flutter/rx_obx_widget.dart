import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import '../../../get_rx/src/rx_types/rx_types.dart';

typedef WidgetCallback = Widget Function();

/// The [ObxWidget] is the base for all GetX reactive widgets
///
/// See also:
/// - [Obx]
/// - [ObxValue]
abstract class ObxWidget extends StatefulWidget {
  const ObxWidget({super.key});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<Function>.has('builder', build));
  }

  @override
  ObxState createState() => ObxState();

  @protected
  Widget build();
}

class ObxState extends State<ObxWidget> {
  final _observer = RxNotifier();
  late StreamSubscription subs;

  @override
  void initState() {
    super.initState();
    subs = _observer.listen(_updateTree, cancelOnError: false);
  }

  void _updateTree(dynamic _) {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    subs.cancel();
    _observer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      RxInterface.notifyChildren(_observer, widget.build);
}

/// The simplest reactive widget in GetX.
///
/// Just pass your Rx variable in the root scope of the callback to have it
/// automatically registered for changes.
///
/// final _name = "GetX".obs;
/// Obx(() => Text( _name.value )),... ;
class Obx extends ObxWidget {
  final WidgetCallback builder;

  const Obx(this.builder, {super.key});

  @override
  Widget build() => builder();
}

/// Similar to [Obx], but manages a **local** reactive state without needing
/// a controller. Pass the initial [RxInterface] value via [initialValue].
///
/// Useful for simple, self-contained states like toggles, counters,
/// visibility flags, selected indices, theme switches, etc.
///
/// The widget automatically rebuilds whenever [initialValue] changes.
///
/// ---
///
/// ### Toggle (bool)
/// ```dart
/// ObxValue(
///   (isActive) => Switch(
///     value: isActive.value,
///     onChanged: (flag) => isActive.value = flag,
///   ),
///   false.obs,
/// )
/// ```
///
/// ### Counter (int)
/// ```dart
/// ObxValue(
///   (count) => Row(
///     children: [
///       IconButton(
///         icon: const Icon(Icons.remove),
///         onPressed: () => count.value--,
///       ),
///       Text('${count.value}'),
///       IconButton(
///         icon: const Icon(Icons.add),
///         onPressed: () => count.value++,
///       ),
///     ],
///   ),
///   0.obs,
/// )
/// ```
///
/// ### Visibility flag
/// ```dart
/// ObxValue(
///   (isVisible) => Visibility(
///     visible: isVisible.value,
///     child: const Text('Hello!'),
///   ),
///   true.obs,
/// )
/// ```
///
/// ### Selected tab index
/// ```dart
/// ObxValue(
///   (selectedIndex) => BottomNavigationBar(
///     currentIndex: selectedIndex.value,
///     onTap: (index) => selectedIndex.value = index,
///     items: const [
///       BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
///       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
///     ],
///   ),
///   0.obs,
/// )
/// ```
class ObxValue<T extends RxInterface> extends ObxWidget {
  final Widget Function(T) builder;

  /// The reactive value passed to [builder].
  ///
  /// Must be an [RxInterface] instance — use `.obs` to create one:
  /// `false.obs`, `0.obs`, `''.obs`, `<String>[].obs`, etc.
  final T initialValue;

  /// Creates an [ObxValue] with positional arguments (classic style).
  ///
  /// ```dart
  /// ObxValue(
  ///   (isActive) => Switch(
  ///     value: isActive.value,
  ///     onChanged: (flag) => isActive.value = flag,
  ///   ),
  ///   false.obs,
  /// )
  /// ```
  const ObxValue(this.builder, this.initialValue, {super.key});

  /// Creates an [ObxValue] with a named [initialValue] parameter (explicit style).
  ///
  /// Useful when the value type needs to be clear at the call site.
  ///
  /// ```dart
  /// ObxValue.named(
  ///   (isVisible) => Visibility(
  ///     visible: isVisible.value,
  ///     child: const Text('Hello!'),
  ///   ),
  ///   initialValue: true.obs,
  /// )
  /// ```
  ///
  /// ```dart
  /// ObxValue.named(
  ///   (count) => Text('${count.value}'),
  ///   initialValue: 0.obs,
  /// )
  /// ```
  const ObxValue.named(
    this.builder, {
    required this.initialValue,
    super.key,
  });

  @override
  Widget build() => builder(initialValue);
}
