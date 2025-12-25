import 'exceptions.dart';

/// A Result type for handling success and failure cases in a type-safe way.
/// Inspired by Rust's Result type and functional programming patterns.
///
/// Example usage:
/// ```dart
/// final result = await apiService.fetchUser(id);
/// result.when(
///   success: (user) => print('User: ${user.name}'),
///   failure: (error) => print('Error: ${error.message}'),
/// );
/// ```
sealed class Result<T> {
  const Result();

  /// Creates a successful result with the given value.
  factory Result.success(T value) = Success<T>;

  /// Creates a failed result with the given error.
  factory Result.failure(GetHttpException error) = Failure<T>;

  /// Returns true if this is a successful result.
  bool get isSuccess => this is Success<T>;

  /// Returns true if this is a failed result.
  bool get isFailure => this is Failure<T>;

  /// Returns the value if successful, otherwise returns null.
  T? get valueOrNull => switch (this) {
    Success<T>(:final value) => value,
    Failure<T>() => null,
  };

  /// Returns the error if failed, otherwise returns null.
  GetHttpException? get errorOrNull => switch (this) {
    Success<T>() => null,
    Failure<T>(:final error) => error,
  };

  /// Returns the value if successful, otherwise returns the provided default.
  T getOrElse(T defaultValue) => switch (this) {
    Success<T>(:final value) => value,
    Failure<T>() => defaultValue,
  };

  /// Returns the value if successful, otherwise computes a default from the error.
  T getOrElseCompute(T Function(GetHttpException error) compute) =>
      switch (this) {
        Success<T>(:final value) => value,
        Failure<T>(:final error) => compute(error),
      };

  /// Returns the value if successful, otherwise throws the error.
  T getOrThrow() => switch (this) {
    Success<T>(:final value) => value,
    Failure<T>(:final error) => throw error,
  };

  /// Pattern matching for Result.
  R when<R>({
    required R Function(T value) success,
    required R Function(GetHttpException error) failure,
  }) => switch (this) {
    Success<T>(:final value) => success(value),
    Failure<T>(:final error) => failure(error),
  };

  /// Pattern matching with nullable return.
  R? whenOrNull<R>({
    R Function(T value)? success,
    R Function(GetHttpException error)? failure,
  }) => switch (this) {
    Success<T>(:final value) => success?.call(value),
    Failure<T>(:final error) => failure?.call(error),
  };

  /// Maps the success value to a new type.
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
    Success<T>(:final value) => Result.success(transform(value)),
    Failure<T>(:final error) => Result.failure(error),
  };

  /// Maps the success value to a new Result.
  Result<R> flatMap<R>(Result<R> Function(T value) transform) => switch (this) {
    Success<T>(:final value) => transform(value),
    Failure<T>(:final error) => Result.failure(error),
  };

  /// Maps the error to a new error.
  Result<T> mapError(
    GetHttpException Function(GetHttpException error) transform,
  ) => switch (this) {
    Success<T>() => this,
    Failure<T>(:final error) => Result.failure(transform(error)),
  };

  /// Recovers from an error by providing an alternative value.
  Result<T> recover(T Function(GetHttpException error) recovery) =>
      switch (this) {
        Success<T>() => this,
        Failure<T>(:final error) => Result.success(recovery(error)),
      };

  /// Recovers from an error by providing an alternative Result.
  Result<T> recoverWith(Result<T> Function(GetHttpException error) recovery) =>
      switch (this) {
        Success<T>() => this,
        Failure<T>(:final error) => recovery(error),
      };

  /// Executes a side effect on success.
  Result<T> onSuccess(void Function(T value) action) {
    if (this case Success<T>(:final value)) {
      action(value);
    }
    return this;
  }

  /// Executes a side effect on failure.
  Result<T> onFailure(void Function(GetHttpException error) action) {
    if (this case Failure<T>(:final error)) {
      action(error);
    }
    return this;
  }

  /// Converts Result to a Future.
  Future<T> toFuture() async => getOrThrow();
}

/// Represents a successful result.
final class Success<T> extends Result<T> {
  final T value;

  const Success(this.value);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Success<T> &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'Success($value)';
}

/// Represents a failed result.
final class Failure<T> extends Result<T> {
  final GetHttpException error;

  const Failure(this.error);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure<T> &&
          runtimeType == other.runtimeType &&
          error == other.error;

  @override
  int get hashCode => error.hashCode;

  @override
  String toString() => 'Failure($error)';
}

/// Extension methods for working with [Future] of [Result].
extension FutureResultExtension<T> on Future<Result<T>> {
  /// Maps the success value of a Future Result.
  Future<Result<R>> mapAsync<R>(R Function(T value) transform) async {
    final result = await this;
    return result.map(transform);
  }

  /// FlatMaps the success value of a Future Result.
  Future<Result<R>> flatMapAsync<R>(
    Future<Result<R>> Function(T value) transform,
  ) async {
    final result = await this;
    return switch (result) {
      Success<T>(:final value) => transform(value),
      Failure<T>(:final error) => Result.failure(error),
    };
  }

  /// Recovers from an error in a Future Result.
  Future<Result<T>> recoverAsync(
    Future<Result<T>> Function(GetHttpException error) recovery,
  ) async {
    final result = await this;
    return switch (result) {
      Success<T>() => result,
      Failure<T>(:final error) => recovery(error),
    };
  }

  /// Gets the value or throws the error.
  Future<T> getOrThrowAsync() async {
    final result = await this;
    return result.getOrThrow();
  }

  /// Gets the value or returns a default.
  Future<T> getOrElseAsync(T defaultValue) async {
    final result = await this;
    return result.getOrElse(defaultValue);
  }
}

/// Extension for converting Response to Result.
extension ResultFromResponse<T> on Future<T> {
  /// Wraps a Future in a Result, catching any exceptions.
  Future<Result<T>> toResult() async {
    try {
      final value = await this;
      return Result.success(value);
    } on GetHttpException catch (e) {
      return Result.failure(e);
    } catch (e, stackTrace) {
      return Result.failure(
        GetHttpException(e.toString(), stackTrace: stackTrace),
      );
    }
  }
}
