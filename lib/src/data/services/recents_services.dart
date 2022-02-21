import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/constants.dart';
import 'hive_services.dart';

class RecentsServices {
  final HiveServices _hiveServices = HiveServices();

  Future<Box> createRecents() async {
    return await _hiveServices.initRecentsBox();
  }

  Future<void> addToRecents(SongModel recentlyPlayed) async {
    Box _recentsBox = _hiveServices.getRecentsBox();
    if (_recentsBox.isEmpty || _recentsBox.length <= recentsListSize) {
      _hiveServices.addToRecentsBox(
        recentlyPlayed.id,
        jsonEncode({
          'song': recentlyPlayed.getMap,
          'time': DateTime.now().toIso8601String(),
        }),
      );
    } else {
      _hiveServices.rmOldestFromRecentsBox();

      _hiveServices.addToRecentsBox(
        recentlyPlayed.id,
        jsonEncode({
          'song': recentlyPlayed.getMap,
          'time': DateTime.now().toIso8601String(),
        }),
      );
    }
  }

  Future<void> clear() async {
    await _hiveServices.clearRecentsBox();
  }
}
