import 'package:on_audio_query/on_audio_query.dart';

class PlayerEvents {
  const PlayerEvents();
}

class ChangeSong extends PlayerEvents {
  final SongModel song;
  const ChangeSong({required this.song});
}
