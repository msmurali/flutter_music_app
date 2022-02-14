import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'bloc/recents_bloc/bloc.dart';

class Player {
  Player._();

  static final Player instance = Player._();

  final AudioPlayer audioPlayer = AudioPlayer(playerId: '5ed7f');

  Future<void> playLocalFile(SongModel song, BuildContext context) async {
    String filePath = song.data;

    await audioPlayer.play(
      filePath,
      isLocal: true,
      volume: 0.4, // TODO:
    );

    RecentsBloc _recentsBloc = BlocProvider.of<RecentsBloc>(context);
    _recentsBloc.add(AddSongEventToRecents(song: song));
  }

  Future<int> pause() async {
    return await audioPlayer.pause();
  }

  Future<int> seek(Duration duration) async {
    return await audioPlayer.seek(duration);
  }
}
