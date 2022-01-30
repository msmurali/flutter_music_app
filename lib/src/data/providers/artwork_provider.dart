import 'dart:typed_data';
import 'package:audiotagger/audiotagger.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtworkProvider {
  final Audiotagger _audiotagger = Audiotagger();

  Future<Uint8List?> getArtworkData(SongModel song) async {
    Uint8List? result = await _audiotagger.readArtwork(path: song.data);
    return result;
  }
}
