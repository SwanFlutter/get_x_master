import 'dart:async';

/// A class to manage microtasks execution.
class GetMicrotask {
  int _version = 0;
  int _microtask = 0;

  /// Returns the current microtask count.
  int get microtask => _microtask;

  /// Returns the current version.
  int get version => _version;

  /// Executes the given callback as a microtask.
  ///
  /// Example:
  /// ```dart
  /// GetMicrotask().exec(() {
  ///   print("Microtask executed");
  /// });
  /// ```
  void exec(Function callback) {
    if (_microtask == _version) {
      _microtask++;
      scheduleMicrotask(() {
        _version++;
        _microtask = _version;
        callback();
      });
    }
  }
}

/// A class to manage a queue of asynchronous jobs.
class GetQueue {
  final List<_Item> _queue = [];
  bool _active = false;

  /// Adds a job to the queue and returns a Future that completes when the job is done.
  ///
  /// Example:
  /// ```dart
  /// GetQueue queue = GetQueue();
  /// queue.add(() async {
  ///   await Future.delayed(Duration(seconds: 1));
  ///   return "Job done";
  /// }).then((result) {
  ///   print(result); // Output: Job done
  /// });
  /// ```
  Future<T> add<T>(Function job) {
    var completer = Completer<T>();
    _queue.add(_Item(completer, job));
    _check();
    return completer.future;
  }

  /// Cancels all jobs in the queue.
  ///
  /// Example:
  /// ```dart
  /// GetQueue queue = GetQueue();
  /// queue.add(() async {
  ///   await Future.delayed(Duration(seconds: 1));
  ///   return "Job done";
  /// });
  /// queue.cancelAllJobs();
  /// ```
  void cancelAllJobs() {
    _queue.clear();
  }

  void _check() async {
    if (!_active && _queue.isNotEmpty) {
      _active = true;
      var item = _queue.removeAt(0);
      try {
        item.completer.complete(await item.job());
      } on Exception catch (e) {
        item.completer.completeError(e);
      }
      _active = false;
      _check();
    }
  }
}

class _Item {
  final dynamic completer;
  final dynamic job;

  _Item(this.completer, this.job);
}
