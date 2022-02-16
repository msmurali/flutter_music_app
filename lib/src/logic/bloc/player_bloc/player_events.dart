import 'package:flutter/cupertino.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerEvents {
  const PlayerEvents();
}

class PlaySongAgain extends PlayerEvents {
  final BuildContext context;
  const PlaySongAgain({required this.context});
}

class PlayNextSong extends PlayerEvents {
  final BuildContext context;
  const PlayNextSong({required this.context});
}

class PlayPreviousSong extends PlayerEvents {
  final BuildContext context;
  const PlayPreviousSong({required this.context});
}

class PlayRandomSong extends PlayerEvents {
  final BuildContext context;
  const PlayRandomSong({required this.context});
}

class AddSongNextToNowPlaying extends PlayerEvents {
  final SongModel song;
  const AddSongNextToNowPlaying({required this.song});
}

class ChangeQueueList extends PlayerEvents {
  final List<SongModel> queue;
  final int index;
  final BuildContext context;
  const ChangeQueueList(
      {required this.queue, required this.index, required this.context});
}
