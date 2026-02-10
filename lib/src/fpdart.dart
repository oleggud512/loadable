import 'package:fpdart/fpdart.dart';
import 'package:loadable/loadable.dart';

extension FpdartExtensions<D, L> on Loadable<D, L> {
  Option<D> toOption() => isData ? some(data) : none();
}

extension FpdartEitherExtensions<D, L, E> on Loadable<Either<E, D>, L> {
  Option<D> eitherToOption() => switch (this) {
    LData(:final data) => data.toOption(),
    _ => none(),
  };

  bool get eitherIsData => switch (this) {
    LData(:final data) => data.isRight(),
    _ => false,
  };

  T foldSimple<T>({
    required T Function(Either<E, D> data) initialOrLoading,
    required T Function(E error) error,
    required T Function(D data) data,
  }) {
    return switch (this) {
      LInitial(:final data) || LLoading(:final data) => initialOrLoading(data),
      LData(data: Left(:final value)) => error(value),
      LData(data: Right(:final value)) => data(value),
    };
  }

  T fold<T>({
    required T Function(Either<E, D> data) initial,
    required T Function(Either<E, D> data, L loading) loading,
    required T Function(E error) error,
    required T Function(D data) data,
  }) {
    return switch (this) {
      LInitial(:final data) => initial(data),
      LLoading(:final data, loading: final l) => loading(data, l),
      LData(data: Left(:final value)) => error(value),
      LData(data: Right(:final value)) => data(value),
    };
  }
}
