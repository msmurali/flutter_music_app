import 'dart:typed_data';
import 'package:audiotagger/audiotagger.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ArtworkProvider {
  final Audiotagger _audiotagger = Audiotagger();

  Future<Uint8List?> getArtworkData(SongModel song) async {
    // print(song.data);
    // print(song.displayName);
    // print(song.uri);
    //  _byteData = await _audiotagger.readArtwork(
    //     path:
    //         '/storage/emulated/0/Download/Lindsey Stirling - Carol of the Bells (Official Video).mp3');
    Uint8List? x = await _audiotagger.readArtwork(
        path:
            '/storage/emulated/0/Download/Lindsey Stirling - Carol of the Bells (Official Video).mp3');
    print(x);
    return null;
  }
}
