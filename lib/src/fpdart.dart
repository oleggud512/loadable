import 'package:fpdart/fpdart.dart';
import 'package:loadable/loadable.dart';

extension FpdartExtensions<D, L> on Loadable<D, L> {
  Option<D> toOption() => isData ? some(data) : none();
}
