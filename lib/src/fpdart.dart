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
}
