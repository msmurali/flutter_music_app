import 'package:on_audio_query/on_audio_query.dart';

import '../providers/playlists_provider.dart';

class PlaylistServices {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final PlaylistsProvider _playlistsProvider = PlaylistsProvider();

  static Future<int> getPlaylistId(String playlistName) async {
    late int _id;
    final PlaylistsProvider _provider = PlaylistsProvider();
    List<PlaylistModel> _playlists = await _provider.getPlaylists();
    print(_playlists.length);
    _playlists.map((playlist) {
      if (playlist.playlist == playlistName) {
        _id = playlist.id;
      }
    });

    return _id;
  }

  Future<bool> createPlaylist(String playlistName) async {
    return await _audioQuery.createPlaylist(playlistName);
  }

  Future<bool> rmPlaylist(int playlistId) async {
    return await _audioQuery.removePlaylist(playlistId);
  }

  Future<bool> playlistAlreadyExists(playlistName) async {
    bool _alreadyExists = false;

    List<PlaylistModel> _playlists = await _playlistsProvider.getPlaylists();

    _playlists.map((playlist) {
      if (playlist.playlist == playlistName) {
        _alreadyExists = true;
      }
    });

    return _alreadyExists;
  }

  Future<bool> addToPlaylist(int playlistId, SongModel song) async {
    return await _audioQuery.addToPlaylist(playlistId, song.id);
  }

  Future<bool> addAllToPlaylist(int playlistId, List<SongModel> songs) async {
    bool _result = true;

    PlaylistServices _playlistServices = PlaylistServices();

    songs.map((song) async {
      _result = await _playlistServices.addToPlaylist(playlistId, song);
    });

    return _result;
  }

  Future<bool> songAlreadyInPlaylist(
    SongModel song,
    String playlistName,
  ) async {
    bool _alreadyExists = false;

    int _playlistId = await getPlaylistId(playlistName);

    List<SongModel> _playlistSongs =
        await _playlistsProvider.getPlaylistSongs(_playlistId);

    for (int indx = 0; indx < _playlistSongs.length; indx++) {
      if (_playlistSongs[indx].title == song.title) {
        _alreadyExists = true;
      }
    }

    return _alreadyExists;
  }

  Future<bool> rmFromPlaylist(int playlistId, int songId) async {
    return await _audioQuery.removeFromPlaylist(playlistId, songId);
  }

  Future<void> clearPlaylist(int playlistId) async {
    List<SongModel> _playlistSongs =
        await _playlistsProvider.getPlaylistSongs(playlistId);

    for (int indx = 0; indx < _playlistSongs.length; indx++) {
      await rmFromPlaylist(playlistId, _playlistSongs[indx].id);
    }
  }
}
