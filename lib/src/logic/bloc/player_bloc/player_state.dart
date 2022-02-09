import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

class PlayerBlocState {
  final SongModel nowPlaying;
  final Uint8List? artworkData;

  const PlayerBlocState({
    required this.nowPlaying,
    required this.artworkData,
  });
}
