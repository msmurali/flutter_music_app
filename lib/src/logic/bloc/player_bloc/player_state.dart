import 'dart:typed_data';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerState {
  final SongModel nowPlaying;
  final Uint8List? artworkData;

  const PlayerState({
    required this.nowPlaying,
    required this.artworkData,
  });
}
