import 'dart:typed_data';

import 'package:flutter/material.dart' hide Action;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:music/src/data/models/playlist.dart';
import 'package:music/src/data/providers/playlists_provider.dart';
import 'package:music/src/data/services/favourites_services.dart';
import 'package:music/src/data/services/playlist_services.dart';
import 'package:music/src/global/constants/index.dart';
import 'package:music/src/logic/bloc/playlists_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'src/data/providers/artwork_provider.dart';
import 'src/data/providers/favourites_provider.dart';
import 'src/data/providers/queue_provider.dart';
import 'src/data/providers/recents_provider.dart';

import 'src/data/services/app_permissions.dart';
import 'src/data/services/hive_services.dart';
import 'src/data/services/player_services.dart';
import 'src/data/services/preferences_services.dart';
import 'src/data/services/queue_services.dart';

import 'src/logic/bloc/index.dart';

import 'src/app.dart';

final HiveServices _hiveServices = HiveServices();
final PreferencesServices _preferencesServices = PreferencesServices();
final FavouritesProvider _favouritesProvider = FavouritesProvider();
final FavouritesServices _favouritesServices = FavouritesServices();
final QueueProvider _queueProvider = QueueProvider();
final QueueServices _queueServices = QueueServices();
final ArtworkProvider _artworkProvider = ArtworkProvider();
final RecentsProvider _recentsProvider = RecentsProvider();
final PlayerServices _playerServices = PlayerServices();
final PlaylistsProvider _playlistsProvider = PlaylistsProvider();
final PlaylistServices _playlistServices = PlaylistServices();

late List<SongModel> queueSongs;
late int queueIndex;
late Uint8List? initialArtworkData;
late List<Playlist> playlists;

Future<void> _getStorageAccessPermission() async {
  await AppPermissions.requestPermissions();
}

Future<void> _getQueueSongs() async {
  queueSongs = await _queueProvider.getQueue();
}

Future<void> _getSongArtwork() async {
  initialArtworkData =
      await _artworkProvider.getSongArtwork(queueSongs[queueIndex]);
}

Future<void> _getPlaylists() async {
  playlists = await _playlistsProvider.getPlaylists();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _hiveServices.init();

  await _getStorageAccessPermission();
  // print(await _favouritesServices.createFavourites());
  await _favouritesServices.clearFavourites();
  await _getQueueSongs();
  await _hiveServices.setQueueIndex(0); // TODO:
  await _playlistServices.clear();
  await _getPlaylists();
  queueIndex = _queueServices.getQueueIndex();
  await _getSongArtwork();

  Widget source = MultiBlocProvider(
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
            queue: queueSongs,
            nowPlaying: queueIndex,
            artworkData: initialArtworkData,
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
            playlists: playlists,
            action: Action.none,
            status: Status.none,
          ),
        ),
      ),
    ],
    child: const AppWidget(),
  );
  await Hive.box(keys[StorageKey.recents]!).clear(); // TODO:
  runApp(source);
}
