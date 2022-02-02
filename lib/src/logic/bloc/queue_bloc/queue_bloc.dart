import 'package:bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/providers/songs_provider.dart';
import '../../../data/services/app_shared_preferences.dart';
import 'bloc.dart';

class QueueBloc extends Bloc<QueueEvents, QueueState> {
  final SongsProvider _songsProvider = SongsProvider();
  final AppSharedPreferences _preferences = AppSharedPreferences();

  QueueBloc(QueueState initialState) : super(initialState) {
    on<AddSongToQueueEvent>(_onAddSongEvent);
    on<ChangeQueueEvent>(_onChangeQueueEvent);
    on<PlayNextEvent>(_onPlayNextEvent);
    on<ResetQueueEvent>(_onResetQueueEvent);
  }

  _onAddSongEvent(
    AddSongToQueueEvent event,
    Emitter<QueueState> emitter,
  ) async {
    List<SongModel> newSongs = state.songs;

    newSongs.add(event.song);

    QueueState newState = QueueState(
      songs: newSongs,
    );

    emitter.call(newState);

    await _preferences.setQueueList(newState.songs);
  }

  _onChangeQueueEvent(
    ChangeQueueEvent event,
    Emitter<QueueState> emitter,
  ) async {
    List<SongModel> newSongs = event.songs;

    QueueState newState = QueueState(
      songs: newSongs,
    );

    emitter.call(newState);

    await _preferences.setQueueList(newState.songs);
  }

  _onPlayNextEvent(
    PlayNextEvent event,
    Emitter<QueueState> emitter,
  ) async {
    List<SongModel> _newSongs = state.songs;
    _newSongs.insert(event.queueIndex, event.song);

    QueueState newState = QueueState(
      songs: _newSongs,
    );

    emitter.call(newState);

    await _preferences.setQueueList(newState.songs);
  }

  _onResetQueueEvent(
    ResetQueueEvent event,
    Emitter<QueueState> emitter,
  ) async {
    List<SongModel> _newSongs = await _songsProvider.getSongs();

    QueueState newState = QueueState(
      songs: _newSongs,
    );

    emitter.call(newState);

    await _preferences.setQueueList(newState.songs);
  }
}
