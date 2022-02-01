class QueueIndexEvent {
  const QueueIndexEvent();
}

class QueueIndexIncrementEvent extends QueueIndexEvent {
  final int currIndex;
  final int queueSize;
  const QueueIndexIncrementEvent({
    required this.currIndex,
    required this.queueSize,
  });
}

class QueueIndexDecrementEvent extends QueueIndexEvent {
  final int currIndex;
  final int queueSize;
  const QueueIndexDecrementEvent({
    required this.currIndex,
    required this.queueSize,
  });
}

class SetQueueIndexEvent extends QueueIndexEvent {
  final int index;
  const SetQueueIndexEvent({required this.index});
}
