import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/index.dart';
import '../providers/favourites_provider.dart';
import 'playlist_services.dart';

class FavouritesServices {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final PlaylistServices _playlistServices = PlaylistServices();
  final FavouritesProvider _favouritesProvider = FavouritesProvider();

  Future<bool> createFavourites() async {
    return await _audioQuery.createPlaylist(keys[StorageKey.favourites]!);
  }

  Future<bool> favouritesAlreadyExists() async {
    return await _playlistServices
        .playlistAlreadyExists(keys[StorageKey.favourites]!);
  }

  Future<bool> addToFavourites(SongModel song) async {
    bool alreadyExists = await songAlreadyInFavourites(song);
    print(alreadyExists);

    if (!alreadyExists) {
      PlaylistModel _favourites = await _favouritesProvider.getFavourites();
      return await _playlistServices.addToPlaylist(_favourites.id, song);
    } else {
      return false;
    }
  }

  Future<bool> addAllToFavourites(List<SongModel> songs) async {
    PlaylistModel _favourites = await _favouritesProvider.getFavourites();
    return await _playlistServices.addAllToPlaylist(_favourites.id, songs);
  }

  Future<bool> songAlreadyInFavourites(SongModel song) async {
    List<SongModel> _favouriteSongs =
        await _favouritesProvider.getFavouritesSongs();

    bool alreadyExists = false;

    for (int indx = 0; indx < _favouriteSongs.length; indx++) {
      if (_favouriteSongs[indx].title == song.title) {
        alreadyExists = true;
      }
    }

    return alreadyExists;
  }

  Future<bool> rmFromFavourites(int songId) async {
    PlaylistModel _favourites = await _favouritesProvider.getFavourites();
    return await _playlistServices.rmFromPlaylist(_favourites.id, songId);
  }

  Future<void> clearFavourites() async {
    PlaylistModel _favourites = await _favouritesProvider.getFavourites();
    await _playlistServices.clearPlaylist(_favourites.id);
  }
}
