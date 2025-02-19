/// Extension for various iterable utilities
extension IterableExtensions<T> on Iterable<T> {
  /// Maps each element of the iterable to an iterable and flattens the result
  ///
  /// Example:
  /// ```dart
  /// List<int> numbers = [1, 2, 3];
  /// List<int> result = numbers.mapMany((n) => [n, n * 2]).toList();
  /// // Result: [1, 2, 2, 4, 3, 6]
  /// ```
  Iterable<TRes> mapMany<TRes>(
      Iterable<TRes>? Function(T item) selector) sync* {
    for (var item in this) {
      final res = selector(item);
      if (res != null) yield* res;
    }
  }
}
