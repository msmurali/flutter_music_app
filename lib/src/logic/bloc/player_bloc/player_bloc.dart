import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/providers/artwork_provider.dart';
import 'bloc.dart';

class PlayerBloc extends Bloc<PlayerEvents, PlayerBlocState> {
  final ArtworkProvider _artworkProvider = ArtworkProvider();

  PlayerBloc({required PlayerBlocState initialState}) : super(initialState) {
    on<ChangeSong>(_onChangeSong);
  }

  Future<void> _onChangeSong(
      ChangeSong event, Emitter<PlayerBlocState> emitter) async {
    SongModel _song = event.song;
    Uint8List? _artworkData;

    _artworkData = await _artworkProvider.getSongArtwork(_song);

    PlayerBlocState _playerState = PlayerBlocState(
      nowPlaying: _song,
      artworkData: _artworkData,
    );

    emitter.call(_playerState);
  }
}
