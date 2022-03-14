import 'package:get/get.dart';
import 'package:purpledog/provider/hacker_news/hacker_news_provider.dart';

enum ObxSnapshotState {
  init,
  loading,
  value,
  error,
}

class ObxSnapshot<T> {
  final ObxSnapshotState state;
  final T? value;
  T get requireData {
    if(state == ObxSnapshotState.value) {
      return value!;
    } else if(state == ObxSnapshotState.error) {
      throw error!;
    }
    throw StateError('ObxSnapshot has neither data nor error');
  }
  final Object? error;

  const ObxSnapshot(this.state, this.value, this.error);

  const ObxSnapshot.init()
      : state = ObxSnapshotState.init,
        value = null,
        error = null;

  const ObxSnapshot.loading()
      : state = ObxSnapshotState.loading,
        value = null,
        error = null;

  const ObxSnapshot.value(T _value)
      : state = ObxSnapshotState.value,
        value = _value,
        error = null;

  const ObxSnapshot.error(Object _error)
      : state = ObxSnapshotState.error,
        value = null,
        error = _error;

  ObxSnapshot<T> copyWithState(ObxSnapshotState state) =>
      ObxSnapshot(state, value, error);

}
