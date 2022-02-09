import 'dart:convert';
import 'package:on_audio_query/on_audio_query.dart';
import 'hive_services.dart';

class QueueServices {
  final HiveServices _hiveServices = HiveServices();

  Future<void> setQueue(List<SongModel> songs) {
    List<String> _songsMapStringList =
        songs.map((song) => jsonEncode(song.getMap)).toList();

    return _hiveServices.setQueue(_songsMapStringList);
  }

  Future<void> setQueueIndex(int index) async {
    await _hiveServices.setQueueIndex(index);
  }

  int getQueueIndex() {
    return _hiveServices.getQueueIndex() ?? 0;
  }
}
