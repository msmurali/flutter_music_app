import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/constants.dart';
import '../../global/constants/enums.dart';

class PlaylistsProvider {
  final OnAudioQuery _audioQuery = OnAudioQuery();

  Future<List<PlaylistModel>> getPlaylists() async {
    List<PlaylistModel> result = await _audioQuery.queryPlaylists();
    result.removeWhere((playlist) {
      return playlist.playlist == keys[StorageKey.favourites];
    });
    return result;
  }

  /* get playlist specific songs*/
  Future<List<SongModel>> getPlaylistSongs(int playlistId) async {
    return await _audioQuery.queryAudiosFrom(
      AudiosFromType.PLAYLIST,
      playlistId,
    );
  }
}
