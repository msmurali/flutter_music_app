import 'dart:convert';

import 'package:on_audio_query/on_audio_query.dart';

class Playlist {
  final String name;
  final List<SongModel> songs;
  final int numOfSongs;

  Playlist({
    required this.name,
    required this.songs,
    required this.numOfSongs,
  });

  factory Playlist.fromMap(
    String playlistName,
    Map<dynamic, dynamic> encodedSongsData,
  ) {
    List<SongModel> songs = encodedSongsData.values
        .map((data) => SongModel(jsonDecode(data)))
        .toList();

    return Playlist(
      name: playlistName,
      songs: songs,
      numOfSongs: songs.length,
    );
  }

  Map<int, String> toMap() {
    Map<int, String> map = {};
    for (var song in songs) {
      map[song.id] = jsonEncode(song.getMap);
    }
    return map;
  }
}
