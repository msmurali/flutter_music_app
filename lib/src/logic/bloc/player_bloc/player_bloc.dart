import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:music/src/data/providers/artwork_provider.dart';
import 'package:music/src/data/services/queue_services.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../player.dart';
import 'bloc.dart';

class PlayerBloc extends Bloc<PlayerEvents, PlayerBlocState> {
  final ArtworkProvider _artworkProvider = ArtworkProvider();
  final QueueServices _queueServices = QueueServices();
  final Player _player = Player.instance;

  PlayerBloc({required PlayerBlocState initialState}) : super(initialState) {
    on<PlaySongAgain>(_onPlaySongAgain);
    on<PlayNextSong>(_onPlayNextSongEvent);
    on<PlayPreviousSong>(_onPlayPreviousSongEvent);
    on<PlayRandomSong>(_onPlayRandomSongEvent);
    on<AddSongNextToNowPlaying>(_onAddSongNextToNowPlaying);
    on<ChangeQueueList>(_onChangeQueueList);
  }

  Future<void> _onPlaySongAgain(
    PlaySongAgain event,
    Emitter<PlayerBlocState> emitter,
  ) async {
    List<SongModel> queue = state.queue;
    int index = state.nowPlaying;

    await _player.playLocalFile(
      queue[index],
      event.context,
    );

    emitter.call(state);
  }

  Future<void> _onPlayNextSongEvent(
    PlayNextSong event,
    Emitter<PlayerBlocState> emitter,
  ) async {
    int _newIndex =
        state.nowPlaying + 1 < state.queue.length ? state.nowPlaying + 1 : 0;
    Uint8List? _newArtworkData =
        await _artworkProvider.getSongArtwork(state.queue[_newIndex]);

    PlayerBlocState _newState = PlayerBlocState(
      queue: state.queue,
      nowPlaying: _newIndex,
      artworkData: _newArtworkData,
    );

    await _player.playLocalFile(
      _newState.queue[_newState.nowPlaying],
      event.context,
    );

    emitter.call(_newState);

    await _queueServices.setQueueIndex(_newIndex);
  }

  Future<void> _onPlayPreviousSongEvent(
    PlayPreviousSong event,
    Emitter<PlayerBlocState> emitter,
  ) async {
    int _newIndex = state.nowPlaying - 1 >= 0
        ? state.nowPlaying - 1
        : state.queue.length - 1;
    Uint8List? _newArtworkData =
        await _artworkProvider.getSongArtwork(state.queue[_newIndex]);

    PlayerBlocState _newState = PlayerBlocState(
      queue: state.queue,
      nowPlaying: _newIndex,
      artworkData: _newArtworkData,
    );

    await _player.playLocalFile(
      _newState.queue[_newState.nowPlaying],
      event.context,
    );

    emitter.call(_newState);

    await _queueServices.setQueueIndex(_newIndex);
  }

  Future<void> _onPlayRandomSongEvent(
    PlayRandomSong event,
    Emitter<PlayerBlocState> emitter,
  ) async {
    final Random _random = Random();

    int _rangeMax = state.queue.length;

    int _newIndex = _random.nextInt(_rangeMax);

    Uint8List? _newArtworkData =
        await _artworkProvider.getSongArtwork(state.queue[_newIndex]);

    PlayerBlocState _newState = PlayerBlocState(
      queue: state.queue,
      nowPlaying: _newIndex,
      artworkData: _newArtworkData,
    );

    await _player.playLocalFile(
      _newState.queue[_newState.nowPlaying],
      event.context,
    );

    emitter.call(_newState);

    await _queueServices.setQueueIndex(_newIndex);
  }

  Future<void> _onAddSongNextToNowPlaying(
    AddSongNextToNowPlaying event,
    Emitter<PlayerBlocState> emitter,
  ) async {
    List<SongModel> _newQueue = state.queue;

    _newQueue.insert(state.nowPlaying + 1, event.song);

    PlayerBlocState _newState = PlayerBlocState(
      queue: _newQueue,
      nowPlaying: state.nowPlaying,
      artworkData: state.artworkData,
    );

    emitter.call(_newState);

    await _queueServices.setQueue(_newQueue);
  }

  Future<void> _onChangeQueueList(
    ChangeQueueList event,
    Emitter<PlayerBlocState> emitter,
  ) async {
    List<SongModel> _newQueue = event.queue;

    int _newIndex = event.index;

    Uint8List? _newArtwork =
        await _artworkProvider.getSongArtwork(_newQueue[_newIndex]);

    PlayerBlocState _newState = PlayerBlocState(
      queue: _newQueue,
      nowPlaying: _newIndex,
      artworkData: _newArtwork,
    );

    await _player.playLocalFile(
      _newState.queue[_newState.nowPlaying],
      event.context,
    );

    emitter.call(_newState);

    await _queueServices.setQueueIndex(_newIndex);
    await _queueServices.setQueue(_newQueue);
  }
}
