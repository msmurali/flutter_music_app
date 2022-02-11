import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/index.dart';
import 'playlists_provider.dart';

class FavouritesProvider {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final PlaylistsProvider _playlistsProvider = PlaylistsProvider();

  Future<PlaylistModel> getFavourites() async {
    List<PlaylistModel> result = await _audioQuery.queryPlaylists();

    result.removeWhere(
        (playlist) => playlist.playlist != keys[StorageKey.favourites]);

    return result[0];
  }

  Future<List<SongModel>> getFavouritesSongs() async {
    PlaylistModel _favourites = await FavouritesProvider().getFavourites();
    return await _playlistsProvider.getPlaylistSongs(_favourites.id);
  }
}
