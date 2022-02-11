import 'package:on_audio_query/on_audio_query.dart';

class RecentsEvents {
  const RecentsEvents();
}

class AddSongEventToRecents extends RecentsEvents {
  final SongModel song;

  const AddSongEventToRecents({required this.song});
}
