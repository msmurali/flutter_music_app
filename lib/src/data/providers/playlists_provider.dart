import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:music/src/data/services/hive_services.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../models/playlist.dart';

class PlaylistsProvider {
  final HiveServices _hiveServices = HiveServices();

  Playlist getPlaylist(String playlistName) {
    Box _playlistsBox = _hiveServices.getPlaylistsBox();
    Map<int, String> _playlist = _playlistsBox.get(playlistName);
    return Playlist.fromMap(playlistName, _playlist);
  }

  Future<List<Playlist>> getPlaylists() async {
    Box _playlistsBox = _hiveServices.getPlaylistsBox();

    return _playlistsBox
        .toMap()
        .keys
        .map((key) => Playlist.fromMap(
              key,
              _playlistsBox.get(key),
            ))
        .toList();
  }

  /* get playlist specific songs*/
  Future<List<SongModel>> getPlaylistSongs(String playlistName) async {
    Box _playlistsBox = _hiveServices.getPlaylistsBox();

    Map<dynamic, dynamic> _playlist = _playlistsBox.get(playlistName);

    return _playlist.values.map((val) => SongModel(jsonDecode(val))).toList();
  }
}
