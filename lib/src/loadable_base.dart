sealed class Loadable<D, L> {
  final D data;

  const Loadable(this.data);

  const factory Loadable.initial(D data) = LInitial<D, L>;
  const factory Loadable.data(D data) = LData<D, L>;
  const factory Loadable.loading(D data, L loading) = LLoading<D, L>;

  LLoading<D, L> startLoading(L newLoading) => LLoading(data, newLoading);
  LData<D, L> complete(D newData) => LData(newData);
  LInitial<D, L> reset() => LInitial(data);

  bool get isLoading => this is LLoading;
  bool get isData => this is LData;
  bool get isInitial => this is LInitial;

  Loadable<D, L> update(D Function(D data) applyUpdates) {
    return switch (this) {
      LInitial(:final data) => LInitial(applyUpdates(data)),
      LData(:final data) => LData(applyUpdates(data)),
      LLoading(:final data, :final loading) => LLoading(
        applyUpdates(data),
        loading,
      ),
    };
  }
}

final class LInitial<D, L> extends Loadable<D, L> {
  const LInitial(super.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LInitial<D, L> && other.data == data;

  @override
  int get hashCode => Object.hash(runtimeType, data);
}

final class LData<D, L> extends Loadable<D, L> {
  const LData(super.data);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is LData<D, L> && other.data == data;

  @override
  int get hashCode => Object.hash(runtimeType, data);
}

final class LLoading<D, L> extends Loadable<D, L> {
  final L loading;
  const LLoading(super.data, this.loading);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LLoading<D, L> && other.data == data && other.loading == loading;

  @override
  int get hashCode => Object.hash(runtimeType, data, loading);
}
