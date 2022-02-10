import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:music/src/data/services/favourites_services.dart';
import 'package:music/src/global/constants/index.dart';
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

late List<SongModel> favouritesSongs;
late List<SongModel> queueSongs;
late int queueIndex;
late Uint8List? initialArtworkData;

Future<void> _getStorageAccessPermission() async {
  await AppPermissions.requestPermissions();
}

Future<void> _getFavouritesSongs() async {
  favouritesSongs = await _favouritesProvider.getFavouritesSongs();
}

Future<void> _getQueueSongs() async {
  queueSongs = await _queueProvider.getQueue();
}

Future<void> _getSongArtwork() async {
  initialArtworkData =
      await _artworkProvider.getSongArtwork(queueSongs[queueIndex]);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _hiveServices.init();

  await _getStorageAccessPermission();
  // await _favouritesServices.createFavourites();
  await _getFavouritesSongs();
  await _getQueueSongs();
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
            songs: favouritesSongs,
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
        create: (context) => QueueBloc(
          initialState: QueueState(
            songs: queueSongs,
          ),
        ),
      ),
      BlocProvider(
        create: (context) => QueueIndexBloc(
          initialState: QueueIndexState(
            index: queueIndex,
          ),
        ),
      ),
      BlocProvider(
        create: (context) => PlayerBloc(
          initialState: PlayerBlocState(
            artworkData: initialArtworkData,
            nowPlaying: queueSongs[queueIndex],
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
    ],
    child: const AppWidget(),
  );

  // await Hive.box(keys[StorageKey.recents]!).clear();
  runApp(source);
}
