import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

class PlayerBlocState {
  final List<SongModel> queue;
  final int nowPlaying;
  final Uint8List? artworkData;

  const PlayerBlocState({
    required this.queue,
    required this.nowPlaying,
    required this.artworkData,
  });
}
