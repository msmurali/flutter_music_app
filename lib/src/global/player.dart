import 'package:on_audio_query/on_audio_query.dart';

class Player {
  Player._();

  static final Player instance = Player._();

  final OnAudioQuery audioQuery = OnAudioQuery();
  // final AudioPlayer audioPlayer = AudioPlayer(playerId: playerId);

  // Future<int> playLocalFile(String filePath) async {
  //   return await audioPlayer.play(
  //     filePath,
  //     isLocal: true,
  //   );
  // }

  // Future<int> pause() async {
  //   return await audioPlayer.pause();
  // }

  // Future<int> seek(Duration duration) async {
  //   return await audioPlayer.seek(duration);
  // }
}
