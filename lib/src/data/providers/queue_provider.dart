import 'dart:convert';

import 'package:on_audio_query/on_audio_query.dart';

import '../services/hive_services.dart';
import 'songs_provider.dart';

class QueueProvider {
  final HiveServices _hiveServices = HiveServices();
  final SongsProvider _songsProvider = SongsProvider();

  Future<List<SongModel>> getQueue() async {
    List<String>? _songs = _hiveServices.getQueue();
    if (_songs == null || _songs.isEmpty) {
      return await _songsProvider.getSongs();
    }
    return _songs.map((str) => SongModel(json.decode(str))).toList();
  }
}
