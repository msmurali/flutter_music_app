import 'package:bloc/bloc.dart';

import 'bloc.dart';
import '../../../data/services/queue_services.dart';

class QueueIndexBloc extends Bloc<QueueIndexEvent, QueueIndexState> {
  final QueueServices _queueServices = QueueServices();

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
    // print(event.currIndex);
    late int _newIndex;

    if (event.currIndex + 1 < event.queueSize) {
      _newIndex = event.currIndex + 1;
    } else {
      _newIndex = 0;
    }

    emitter.call(QueueIndexState(index: _newIndex));

    await _queueServices.setQueueIndex(_newIndex);
  }

  _onQueueIndexDecrement(
    QueueIndexDecrementEvent event,
    Emitter<QueueIndexState> emitter,
  ) async {
    // print(event.currIndex);
    late int _newIndex;

    if (event.currIndex - 1 >= 0) {
      _newIndex = event.currIndex - 1;
    } else {
      _newIndex = event.queueSize - 1;
    }

    emitter.call(QueueIndexState(index: _newIndex));

    await _queueServices.setQueueIndex(_newIndex);
  }

  _onSetQueueIndex(
    SetQueueIndexEvent event,
    Emitter<QueueIndexState> emitter,
  ) async {
    // print(event.index);
    emitter.call(QueueIndexState(index: event.index));

    await _queueServices.setQueueIndex(event.index);
  }

  // Future<void> _storeQueueIndexInPreferences(int index) async {

  // }
}
