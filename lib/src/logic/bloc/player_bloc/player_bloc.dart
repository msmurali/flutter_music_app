import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:music/src/data/providers/artwork_provider.dart';
import 'package:music/src/logic/bloc/player_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerBloc extends Bloc<PlayerEvents, PlayerState> {
  final ArtworkProvider _artworkProvider = ArtworkProvider();

  PlayerBloc({required PlayerState initialState}) : super(initialState) {
    on<ChangeSong>(_onChangeSong);
  }

  Future<void> _onChangeSong(
      ChangeSong event, Emitter<PlayerState> emitter) async {
    SongModel _song = event.song;
    Uint8List? _artworkData;

    _artworkData = await _artworkProvider.getSongArtwork(_song);

    PlayerState _playerState = PlayerState(
      nowPlaying: _song,
      artworkData: _artworkData,
    );

    emitter.call(_playerState);
  }
}
