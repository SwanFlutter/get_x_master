extension ListSortExtension<T> on List<T> {
  /// Regular list sort
  /// Returns a new sorted list without modifying the original
  /// Example:
  /// ```dart
  /// final numbers = [3, 1, 4, 1, 5];
  /// final sorted = numbers.sortList(); // [1, 1, 3, 4, 5]
  /// final descending = numbers.sortList(descending: true); // [5, 4, 3, 1, 1]
  ///
  ///
  /// ```
  ///
  ///
  List<T> sortList({bool descending = false}) {
    List<T> sorted = List.from(this);
    sorted.sort((a, b) {
      if (descending) {
        return _compareValues(b, a);
      }
      return _compareValues(a, b);
    });
    return sorted;
  }

  /// Sort by a specific field
  /// Returns a new sorted list based on the provided field selector
  /// Example:
  /// ```dart
  /// final people = [
  ///   Person('Alice', 30),
  ///   Person('Bob', 25),
  ///   Person('Charlie', 35)
  /// ];
  /// final sortedByAge = people.sortByField((p) => p.age); // Sorted by age ascending
  ///
  ///
  /// ```
  ///
  ///
  ///
  List<T> sortByField<K extends Comparable>(
    K Function(T) field, {
    bool descending = false,
  }) {
    List<T> sorted = List.from(this);
    sorted.sort((a, b) {
      if (descending) {
        return field(b).compareTo(field(a));
      }
      return field(a).compareTo(field(b));
    });
    return sorted;
  }

  /// Sort by multiple fields
  /// Returns a new sorted list based on multiple comparison functions
  /// Example:
  /// ```dart
  /// final people = [
  ///   Person('Alice', 30),
  ///   Person('Bob', 30),
  ///   Person('Charlie', 25)
  /// ];
  /// final sortedByAgeAndName = people.sortByMultipleFields([
  ///   (a, b) => a.age.compareTo(b.age),
  ///   (a, b) => a.name.compareTo(b.name)
  /// ]);
  ///
  ///
  /// ```
  ///
  ///
  List<T> sortByMultipleFields(List<Comparator<T>> comparators) {
    List<T> sorted = List.from(this);
    sorted.sort((a, b) {
      for (var comparator in comparators) {
        final result = comparator(a, b);
        if (result != 0) return result;
      }
      return 0;
    });
    return sorted;
  }

  /// Sort with custom comparison
  /// Returns a new sorted list using a custom comparison function
  /// Example:
  /// ```dart
  /// final words = ['apple', 'Banana', 'cherry'];
  /// final sortedCaseInsensitive = words.sortWithComparison(
  ///   (a, b) => a.toLowerCase().compareTo(b.toLowerCase())
  /// );
  ///
  ///
  ///
  /// ```
  ///
  ///
  List<T> sortWithComparison(Comparator<T> comparison) {
    List<T> sorted = List.from(this);
    sorted.sort(comparison);
    return sorted;
  }

  /// Sort and remove duplicates
  /// Returns a new sorted list with duplicate elements removed
  /// Example:
  /// ```dart
  /// final numbers = [3, 1, 4, 1, 5, 3];
  /// final uniqueSorted = numbers.sortUnique(); // [1, 3, 4, 5]
  ///
  ///
  /// ```
  ///
  ///
  List<T> sortUnique({bool descending = false}) {
    return sortList(descending: descending).toSet().toList();
  }

  /// Chunk sort - sorts the list in chunks of specified size
  /// Useful for sorting large lists in smaller batches
  /// Example:
  /// ```dart
  /// final numbers = [5, 2, 8, 1, 9, 3, 7, 4, 6];
  /// final chunkSorted = numbers.chunkSort(chunkSize: 3);
  ///
  ///
  ///
  /// ```
  ///
  ///
  List<T> chunkSort({int chunkSize = 1000, bool descending = false}) {
    if (length <= chunkSize) {
      return sortList(descending: descending);
    }

    List<List<T>> chunks = [];
    for (var i = 0; i < length; i += chunkSize) {
      var end = (i + chunkSize < length) ? i + chunkSize : length;
      chunks.add(sublist(i, end).sortList(descending: descending));
    }

    return _mergeSortedChunks(chunks, descending);
  }

  /// Internal method to compare values for sorting
  int _compareValues(T a, T b) {
    if (a is Comparable) {
      return (a as Comparable).compareTo(b);
    }
    return a.toString().compareTo(b.toString());
  }

  /// Internal method to merge sorted chunks
  List<T> _mergeSortedChunks(List<List<T>> chunks, bool descending) {
    if (chunks.length == 1) return chunks.first;

    List<T> result = [];
    List<Iterator<T>> iterators = chunks
        .map((chunk) => chunk.iterator)
        .toList();
    List<bool> hasNext = List.filled(chunks.length, false);
    List<T> current = List.filled(chunks.length, null as T);

    // Initialize iterators
    for (var i = 0; i < iterators.length; i++) {
      hasNext[i] = iterators[i].moveNext();
      if (hasNext[i]) {
        current[i] = iterators[i].current;
      }
    }

    while (hasNext.any((element) => element)) {
      var bestIndex = -1;
      T bestValue = null as T;

      for (var i = 0; i < chunks.length; i++) {
        if (!hasNext[i]) continue;

        if (bestIndex == -1 ||
            (descending
                ? _compareValues(current[i], bestValue) > 0
                : _compareValues(current[i], bestValue) < 0)) {
          bestIndex = i;
          bestValue = current[i];
        }
      }

      if (bestIndex != -1) {
        result.add(bestValue);
        hasNext[bestIndex] = iterators[bestIndex].moveNext();
        if (hasNext[bestIndex]) {
          current[bestIndex] = iterators[bestIndex].current;
        }
      }
    }

    return result;
  }
}
