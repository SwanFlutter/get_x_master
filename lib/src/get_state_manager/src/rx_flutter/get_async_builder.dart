import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../get_x_master.dart';

/// A builder that handles asynchronous operations (Future/Stream) and automatically
/// manages loading, success, error, and empty states.
///
/// This widget provides a more declarative way to handle async data compared to
/// traditional [FutureBuilder] or [StreamBuilder], integrating seamlessly with
/// GetX Master's state management.
class GetAsyncBuilder<T> extends StatefulWidget {
  /// The future function to execute.
  final Future<T> Function()? future;

  /// The stream function to listen to.
  final Stream<T> Function()? stream;

  /// Builder for the success state.
  final Widget Function(BuildContext context, T data) onSuccess;

  /// Builder for the loading state. Defaults to a centered [CircularProgressIndicator].
  final WidgetBuilder? onLoading;

  /// Builder for the error state. Defaults to a professional error view with retry button.
  final Widget Function(BuildContext context, Object error, VoidCallback? onRetry)? onError;

  /// Builder for the empty state.
  final WidgetBuilder? onEmpty;

  /// Optional function to determine if the data is considered "empty" (e.g., an empty list).
  final bool Function(T data)? isEmpty;

  /// Whether to keep showing the old data while loading new data during a reload.
  final bool keepDataOnReload;

  /// Whether to automatically start the async operation on initialization.
  final bool autoLoad;

  const GetAsyncBuilder._({
    super.key,
    this.future,
    this.stream,
    required this.onSuccess,
    this.onLoading,
    this.onError,
    this.onEmpty,
    this.isEmpty,
    this.keepDataOnReload = true,
    this.autoLoad = true,
  });

  /// Creates a [GetAsyncBuilder] for a [Future].
  factory GetAsyncBuilder.future({
    Key? key,
    required Future<T> Function() future,
    required Widget Function(BuildContext context, T data) onSuccess,
    WidgetBuilder? onLoading,
    Widget Function(BuildContext context, Object error, VoidCallback? onRetry)? onError,
    WidgetBuilder? onEmpty,
    bool Function(T data)? isEmpty,
    bool keepDataOnReload = true,
    bool autoLoad = true,
  }) {
    return GetAsyncBuilder._(
      key: key,
      future: future,
      onSuccess: onSuccess,
      onLoading: onLoading,
      onError: onError,
      onEmpty: onEmpty,
      isEmpty: isEmpty,
      keepDataOnReload: keepDataOnReload,
      autoLoad: autoLoad,
    );
  }

  /// Creates a [GetAsyncBuilder] for a [Stream].
  factory GetAsyncBuilder.stream({
    Key? key,
    required Stream<T> Function() stream,
    required Widget Function(BuildContext context, T data) onSuccess,
    WidgetBuilder? onLoading,
    Widget Function(BuildContext context, Object error, VoidCallback? onRetry)? onError,
    WidgetBuilder? onEmpty,
    bool Function(T data)? isEmpty,
    bool keepDataOnReload = true,
    bool autoLoad = true,
  }) {
    return GetAsyncBuilder._(
      key: key,
      stream: stream,
      onSuccess: onSuccess,
      onLoading: onLoading,
      onError: onError,
      onEmpty: onEmpty,
      isEmpty: isEmpty,
      keepDataOnReload: keepDataOnReload,
      autoLoad: autoLoad,
    );
  }

  @override
  State<GetAsyncBuilder<T>> createState() => GetAsyncBuilderState<T>();
}

class GetAsyncBuilderState<T> extends State<GetAsyncBuilder<T>> {
  RxStatus _status = RxStatus.loading();
  T? _data;
  Object? _error;
  StreamSubscription<T>? _subscription;

  @override
  void initState() {
    super.initState();
    if (widget.autoLoad) {
      _start();
    }
  }

  void _start() {
    if (widget.future != null) {
      _runFuture();
    } else if (widget.stream != null) {
      _listenStream();
    }
  }

  /// Manually triggers a reload of the async operation.
  Future<void> reload() async {
    if (!widget.keepDataOnReload) {
      if (mounted) setState(() => _status = RxStatus.loading());
    }
    _start();
  }

  Future<void> _runFuture() async {
    if (!widget.keepDataOnReload || _data == null) {
      if (mounted) setState(() => _status = RxStatus.loading());
    }
    try {
      final result = await widget.future!();
      if (!mounted) return;
      _emitData(result);
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e;
        _status = RxStatus.error(e.toString());
      });
    }
  }

  void _listenStream() {
    _subscription?.cancel();
    if (!widget.keepDataOnReload || _data == null) {
      if (mounted) setState(() => _status = RxStatus.loading());
    }
    _subscription = widget.stream!().listen(
      (event) {
        if (!mounted) return;
        _emitData(event);
      },
      onError: (Object e) {
        if (!mounted) return;
        setState(() {
          _error = e;
          _status = RxStatus.error(e.toString());
        });
      },
    );
  }

  void _emitData(T result) {
    final empty = widget.isEmpty?.call(result) ?? false;
    setState(() {
      _data = result;
      _error = null;
      _status = empty ? RxStatus.empty() : RxStatus.success();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_status.isLoading) {
      if (widget.keepDataOnReload && _data != null) {
        return widget.onSuccess(context, _data as T);
      }
      return widget.onLoading?.call(context) ??
          const Center(child: CircularProgressIndicator());
    }

    if (_status.isError) {
      return widget.onError?.call(context, _error!, reload) ??
          _DefaultErrorView(error: _error!, onRetry: reload);
    }

    if (_status.isEmpty) {
      return widget.onEmpty?.call(context) ??
          const Center(child: Text('No data available'));
    }

    if (_status.isSuccess && _data != null) {
      return widget.onSuccess(context, _data as T);
    }

    return const SizedBox.shrink();
  }
}

/// A professional default error view used by [GetAsyncBuilder].
class _DefaultErrorView extends StatelessWidget {
  final Object error;
  final VoidCallback onRetry;

  const _DefaultErrorView({required this.error, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 60, color: Colors.redAccent),
            const SizedBox(height: 16),
            Text(
              'Oops! Something went wrong',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that observes a controller with [StateMixin] and automatically
/// renders different states (loading, success, error, empty).
///
/// This is a declarative alternative to using `controller.obx()`.
class GetStateView<C extends Object, T> extends StatelessWidget {
  /// The controller instance. If null, it will be found using [Get.find].
  final C? controller;

  /// The tag of the controller if [Get.find] is used.
  final String? tag;

  /// Builder for the success state.
  final Widget Function(BuildContext context, T? data) onSuccess;

  /// Builder for the loading state.
  final WidgetBuilder? onLoading;

  /// Builder for the error state.
  final Widget Function(BuildContext context, String? error)? onError;

  /// Builder for the empty state.
  final WidgetBuilder? onEmpty;

  const GetStateView({
    super.key,
    this.controller,
    this.tag,
    required this.onSuccess,
    this.onLoading,
    this.onError,
    this.onEmpty,
  });

  @override
  Widget build(BuildContext context) {
    final c = controller ?? Get.find<C>(tag: tag);

    if (c is! StateMixin<T>) {
      throw FlutterError(
          'GetStateView: Controller of type ${c.runtimeType} must implement StateMixin<$T>.');
    }

    final stateMixin = c as StateMixin<T>;

    return stateMixin.obx(
      (data) => onSuccess(context, data),
      onLoading: onLoading?.call(context),
      onEmpty: onEmpty?.call(context),
      onError: onError != null ? (error) => onError!(context, error) : null,
    );
  }
}
