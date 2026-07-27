import 'package:equatable/equatable.dart';

sealed class Result<T> extends Equatable {
  const Result();

  R when<R>({
    required R Function(T data) success,
    required R Function(Failure failure) onFailure,
  }) {
    return switch (this) {
      Success<T>(:final data) => success(data),
      Error<T>(:final failure) => onFailure(failure),
    };
  }

  bool get isSuccess => this is Success<T>;
  bool get isFailure => this is Error<T>;

  T? get dataOrNull => switch (this) {
        Success<T>(:final data) => data,
        Error<T>() => null,
      };

  Failure? get failureOrNull => switch (this) {
        Success<T>() => null,
        Error<T>(:final failure) => failure,
      };
}

final class Success<T> extends Result<T> {
  const Success(this.data);

  final T data;

  @override
  List<Object?> get props => [data];
}

final class Error<T> extends Result<T> {
  const Error(this.failure);

  final Failure failure;

  @override
  List<Object?> get props => [failure];
}

class Failure extends Equatable {
  const Failure({
    required this.message,
    this.code,
    this.exception,
  });

  final String message;
  final String? code;
  final Object? exception;

  @override
  List<Object?> get props => [message, code, exception];
}
