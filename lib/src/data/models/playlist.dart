import 'dart:convert';
import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

class Playlist {
  final String name;
  final List<SongModel> songs;

  Playlist({
    required this.name,
    required this.songs,
  });

  factory Playlist.fromMap(
    String playlistName,
    Map<int, String> encodedSongsData,
  ) {
    List<SongModel> songs = encodedSongsData.values
        .map((data) => SongModel(jsonDecode(data)))
        .toList();

    return Playlist(name: playlistName, songs: songs);
  }

  Map<int, String> toMap() {
    Map<int, String> map = {};
    for (var song in songs) {
      map[song.id] = jsonEncode(song.getMap);
    }
    return map;
  }
}
