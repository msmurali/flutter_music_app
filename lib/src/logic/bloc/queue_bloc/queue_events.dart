import 'package:on_audio_query/on_audio_query.dart';

abstract class QueueEvents {
  const QueueEvents();
}

class AddSongToQueueEvent extends QueueEvents {
  final SongModel song;

  const AddSongToQueueEvent({required this.song});
}

class ChangeQueueEvent extends QueueEvents {
  final List<SongModel> songs;

  const ChangeQueueEvent({required this.songs});
}

class PlayNextEvent extends QueueEvents {
  final SongModel song;
  final int queueIndex;

  const PlayNextEvent({required this.song, required this.queueIndex});
}

class ResetQueueEvent extends QueueEvents {}
