import 'package:bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../../data/providers/songs_provider.dart';
import '../../../data/services/queue_services.dart';
import 'bloc.dart';

class QueueBloc extends Bloc<QueueEvents, QueueState> {
  final SongsProvider _songsProvider = SongsProvider();
  final QueueServices _queueServices = QueueServices();

  QueueBloc({required QueueState initialState}) : super(initialState) {
    on<AddSongToQueueEvent>(_onAddSongEvent);
    on<ChangeQueueEvent>(_onChangeQueueEvent);
    on<PlayNextEvent>(_onPlayNextEvent);
    on<ResetQueueEvent>(_onResetQueueEvent);
  }

  _onAddSongEvent(
    AddSongToQueueEvent event,
    Emitter<QueueState> emitter,
  ) async {
    List<SongModel> _newSongs = state.songs;

    _newSongs.add(event.song);

    QueueState newState = QueueState(
      songs: _newSongs,
    );

    emitter.call(newState);

    await _queueServices.setQueue(_newSongs);
  }

  _onChangeQueueEvent(
    ChangeQueueEvent event,
    Emitter<QueueState> emitter,
  ) async {
    List<SongModel> _newSongs = event.songs;

    QueueState newState = QueueState(
      songs: _newSongs,
    );

    emitter.call(newState);

    await _queueServices.setQueue(_newSongs);
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

    await _queueServices.setQueue(_newSongs);
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

    await _queueServices.setQueue(_newSongs);
  }
}
