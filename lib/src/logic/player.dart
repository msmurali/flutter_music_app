import 'package:audioplayers/audioplayers.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player {
  Player._();

  static final Player instance = Player._();

  final AudioPlayer audioPlayer = AudioPlayer(playerId: '5ed7f');

  Future<int> playLocalFile(SongModel song) async {
    String filePath = song.data;

    return await audioPlayer.play(
      filePath,
      isLocal: true,
      volume: 0.4, // TODO:
    );
  }

  Future<int> pause() async {
    return await audioPlayer.pause();
  }

  Future<int> seek(Duration duration) async {
    return await audioPlayer.seek(duration);
  }
}
