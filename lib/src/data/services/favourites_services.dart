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

  Future<bool> addToFavourites(int songId) async {
    PlaylistModel _favourites = await _favouritesProvider.getFavourites();
    return await _playlistServices.addToPlaylist(_favourites.id, songId);
  }

  Future<bool> addAllToFavourites(List<SongModel> songs) async {
    PlaylistModel _favourites = await _favouritesProvider.getFavourites();
    return await _playlistServices.addAllToPlaylist(_favourites.id, songs);
  }

  Future<bool> songAlreadyInFavourites(int songId) async {
    String _favourites = keys[StorageKey.favourites]!;
    return _playlistServices.songAlreadyInPlaylist(songId, _favourites);
  }

  Future<bool> rmFromFavourites(int songId) async {
    PlaylistModel _favourites = await _favouritesProvider.getFavourites();
    return await _playlistServices.rmFromPlaylist(_favourites.id, songId);
  }
}
