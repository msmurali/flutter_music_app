import 'package:on_audio_query/on_audio_query.dart';

class PlayerEvents {
  const PlayerEvents();
}

class PlaySongAgain extends PlayerEvents {
  const PlaySongAgain();
}

class PlayNextSong extends PlayerEvents {
  const PlayNextSong();
}

class PlayPreviousSong extends PlayerEvents {
  const PlayPreviousSong();
}

class PlayRandomSong extends PlayerEvents {
  const PlayRandomSong();
}

class AddSongNextToNowPlaying extends PlayerEvents {
  final SongModel song;
  const AddSongNextToNowPlaying({required this.song});
}

class ChangeQueueList extends PlayerEvents {
  final List<SongModel> queue;
  const ChangeQueueList({required this.queue});
}
