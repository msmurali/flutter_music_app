import 'dart:typed_data';

import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../app.dart';
import '../data/models/playlist.dart';
import '../data/providers/provider.dart';
import '../data/services/app_permissions.dart';
import '../data/services/hive_services.dart';
import '../data/services/player_services.dart';
import '../data/services/preferences_services.dart';
import '../data/services/queue_services.dart';
import '../global/constants/index.dart';
import '../logic/bloc/index.dart';

class Initializer {
  static final HiveServices _hiveServices = HiveServices();
  static final PreferencesServices _preferencesServices = PreferencesServices();
  static final FavouritesProvider _favouritesProvider = FavouritesProvider();
  static final QueueProvider _queueProvider = QueueProvider();
  static final QueueServices _queueServices = QueueServices();
  static final ArtworkProvider _artworkProvider = ArtworkProvider();
  static final RecentsProvider _recentsProvider = RecentsProvider();
  static final PlayerServices _playerServices = PlayerServices();
  static final PlaylistsProvider _playlistsProvider = PlaylistsProvider();

  static late List<SongModel> _queueSongs;
  static late Uint8List? _initialArtworkData;
  static late List<Playlist> _playlists;

  static Future<Widget> initApp() async {
    await _hiveServices.init();
    await _getStorageAccessPermission();
    await _initQueue();
    await _initPlaylists();
    await _initArtwork();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PreferencesBloc(
            initialState: PreferencesState(
              view: _preferencesServices.getView(),
              gridSize: _preferencesServices.getGridSize(),
              songsSortType: _preferencesServices.getSongSortType(),
              songsOrderType: _preferencesServices.getSongOrderType(),
              albumsSortType: _preferencesServices.getAlbumsSortType(),
              albumsOrderType: _preferencesServices.getAlbumOrderType(),
              artistsSortType: _preferencesServices.getArtistSortType(),
              artistsOrderType: _preferencesServices.getArtistOrderType(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => ThemeModeBloc(
            initialState: ThemeModeState(
              themeMode: _preferencesServices.getTheme(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => FavouritesBloc(
            initialState: FavouritesState(
              songs: _favouritesProvider.getFavouritesSongs(),
              action: Action.none,
              status: Status.none,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => RecentsBloc(
            initialState: RecentsState(
              songs: _recentsProvider.getRecents(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => PlayerBloc(
            initialState: PlayerBlocState(
              queue: _queueSongs,
              nowPlaying: _queueServices.getQueueIndex(),
              artworkData: _initialArtworkData,
            ),
          ),
        ),
        BlocProvider(
          create: (context) => PlaybackModeBloc(
            initialState: PlaybackModeState(
              playbackMode: _playerServices.getPlaybackMode(),
            ),
          ),
        ),
        BlocProvider(
          create: (context) => PlaylistsBloc(
            initialState: PlaylistsState(
              playlists: _playlists,
              action: Action.none,
              status: Status.none,
            ),
          ),
        ),
      ],
      child: const AppWidget(),
    );
  }

  static Future<void> _getStorageAccessPermission() async {
    await AppPermissions.requestPermissions();
  }

  static Future<void> _initQueue() async {
    _queueSongs = await _queueProvider.getQueue();
  }

  static Future<void> _initArtwork() async {
    final int queueIndex = _queueServices.getQueueIndex();
    _initialArtworkData =
        await _artworkProvider.getSongArtwork(_queueSongs[queueIndex]);
  }

  static Future<void> _initPlaylists() async {
    _playlists = await _playlistsProvider.getPlaylists();
  }
}
