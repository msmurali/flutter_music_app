import 'dart:convert';
import 'package:music/src/data/services/hive_services.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../providers/playlists_provider.dart';

class PlaylistServices {
  final HiveServices _hiveServices = HiveServices();
  final PlaylistsProvider _playlistsProvider = PlaylistsProvider();

  Future<bool> createPlaylist(String playlistName) async {
    await _hiveServices.createPlaylist(playlistName);
    return _hiveServices.getPlaylistsBox().containsKey(playlistName);
  }

  Future<bool> rmPlaylist(String playlistName) async {
    await _hiveServices.rmPlaylist(playlistName);
    return !_hiveServices.getPlaylistsBox().containsKey(playlistName);
  }

  bool playlistAlreadyExists(playlistName) {
    return _hiveServices.getPlaylistsBox().containsKey(playlistName);
  }

  Future<bool> addToPlaylist(String playlistName, SongModel song) async {
    await _hiveServices.addToPlaylist(
      playlistName,
      song.id,
      jsonEncode(song.getMap),
    );
    return _playlistsProvider
        .getPlaylist(playlistName)
        .toMap()
        .containsKey(song.id);
  }

  Future<bool> rmFromPlaylist(String playlistName, SongModel song) async {
    await _hiveServices.rmFromPlaylist(playlistName, song.id);
    return !_playlistsProvider
        .getPlaylist(playlistName)
        .toMap()
        .containsKey(song.id);
  }

  Future<void> addAllToPlaylist(
    String playlistName,
    List<SongModel> songs,
  ) async {
    await _hiveServices.addAllToPlaylist(
      playlistName,
      songs.map((song) => song.id).toList(),
      songs.map((song) => jsonEncode(song.getMap)).toList(),
    );
  }

  bool songAlreadyInPlaylist(
    String playlistName,
    SongModel song,
  ) {
    return _playlistsProvider
        .getPlaylist(playlistName)
        .toMap()
        .containsKey(song.id);
  }

  Future<bool> renamePlaylist(String oldName, String newName) async {
    Map<int, String> playlist = _playlistsProvider.getPlaylist(oldName).toMap();
    await rmPlaylist(oldName);
    await _hiveServices.createPlaylist(
      newName,
      encodedSongs: playlist,
    );
    return _hiveServices.getPlaylistsBox().containsKey(newName);
  }

  Future<void> clearPlaylist(String playlistName) async {
    await _hiveServices.clearPlaylist(playlistName);
  }

  Future<void> clear() async {
    await _hiveServices.clearPlaylistsBox();
  }
}
