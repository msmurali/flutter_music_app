import './bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:music/src/data/services/player_services.dart';
import 'package:music/src/global/constants/enums.dart';

class PlaybackModeBloc extends Bloc<PlaybackModeEvent, PlaybackModeState> {
  final PlayerServices _playerservices = PlayerServices();

  PlaybackModeBloc(PlaybackModeState initialState) : super(initialState) {
    on<PlaybackModeEvent>(_onPlaybackModeEvent);
  }

  _onPlaybackModeEvent(
    PlaybackModeEvent event,
    Emitter<PlaybackModeState> emitter,
  ) async {
    PlaybackMode _playbackMode = event.playbackMode;

    PlaybackModeState _playbackModeState =
        PlaybackModeState(playbackMode: _playbackMode);

    emitter.call(_playbackModeState);

    await _playerservices.setPlaybackMode(event.playbackMode);
  }
}
