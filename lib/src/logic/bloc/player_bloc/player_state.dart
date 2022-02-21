import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

class PlayerBlocState {
  final List<SongModel> queue;
  final int nowPlaying;
  final Uint8List? artworkData;
  final double volume;

  const PlayerBlocState({
    required this.queue,
    required this.nowPlaying,
    required this.artworkData,
    required this.volume,
  });
}
