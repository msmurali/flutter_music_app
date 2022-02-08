import 'package:bloc/bloc.dart';

import '../../../data/services/app_shared_preferences.dart';
import 'bloc.dart';

class QueueIndexBloc extends Bloc<QueueIndexEvent, QueueIndexState> {
  final AppSharedPreferences _preferences = AppSharedPreferences();

  QueueIndexBloc({required QueueIndexState initialState})
      : super(initialState) {
    on<QueueIndexIncrementEvent>(_onQueueIndexIncrement);
    on<QueueIndexDecrementEvent>(_onQueueIndexDecrement);
    on<SetQueueIndexEvent>(_onSetQueueIndex);
  }

  _onQueueIndexIncrement(
    QueueIndexIncrementEvent event,
    Emitter<QueueIndexState> emitter,
  ) async {
    late int _newIndex;

    if (event.currIndex + 1 < event.queueSize) {
      _newIndex = event.currIndex + 1;
    } else {
      _newIndex = 0;
    }

    emitter.call(QueueIndexState(index: _newIndex));

    await _storeQueueIndexInPreferences(_newIndex);
  }

  _onQueueIndexDecrement(
    QueueIndexDecrementEvent event,
    Emitter<QueueIndexState> emitter,
  ) async {
    late int _newIndex;

    if (event.currIndex - 1 >= 0) {
      _newIndex = event.currIndex - 1;
    } else {
      _newIndex = event.queueSize - 1;
    }

    emitter.call(QueueIndexState(index: _newIndex));

    await _storeQueueIndexInPreferences(_newIndex);
  }

  _onSetQueueIndex(
    SetQueueIndexEvent event,
    Emitter<QueueIndexState> emitter,
  ) async {
    emitter.call(QueueIndexState(index: event.index));

    await _storeQueueIndexInPreferences(event.index);
  }

  Future<void> _storeQueueIndexInPreferences(int index) async {
    await _preferences.setQueueIndex(index);
  }
}
