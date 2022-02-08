import 'package:audioplayers/audioplayers.dart';

class Player {
  Player._();

  static final Player instance = Player._();

  final AudioPlayer audioPlayer = AudioPlayer(playerId: '5ed7f');

  Future<int> playLocalFile(String filePath) async {
    return await audioPlayer.play(
      filePath,
      isLocal: true,
    );
  }

  Future<int> pause() async {
    return await audioPlayer.pause();
  }

  Future<int> seek(Duration duration) async {
    return await audioPlayer.seek(duration);
  }
}
