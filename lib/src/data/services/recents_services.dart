import 'dart:convert';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/constants.dart';
import '../providers/recents_provider.dart';
import 'hive_services.dart';

class RecentsServices {
  final HiveServices _hiveServices = HiveServices();
  final RecentsProvider _recentsProvider = RecentsProvider();

  Future<Box> createRecents() async {
    return await _hiveServices.initRecentsBox();
  }

  Future<void> addToRecents(SongModel recentlyPlayed) async {
    Box _recentsBox = _hiveServices.getRecentsBox();
    String str = jsonEncode(recentlyPlayed.getMap);
    if (_recentsBox.isEmpty) {
      _hiveServices.addToRecentsBox(str);
    } else {
      int? _key = songAlreadyInRecents(recentlyPlayed);
      if (_key != null) {
        String str = _recentsProvider.getFromRecents(_key);
        await _hiveServices.rmFromRecentsBox(_key);
        await _hiveServices.addToRecentsBox(str);
      } else {
        if (_recentsBox.length + 1 > recentsListSize) {
          await _hiveServices.rmOldestFromRecentsBox();
        }
        await _hiveServices.addToRecentsBox(
          json.encode(recentlyPlayed.getMap),
        );
      }
    }
  }

  Future<void> rmFromRecents({int? key}) async {
    if (key != null) {
      return await _hiveServices.rmFromRecentsBox(key);
    } else {
      return await _hiveServices.rmOldestFromRecentsBox();
    }
  }

  int? songAlreadyInRecents(SongModel recentlyPlayed) {
    Box _recentsBox = _hiveServices.getRecentsBox();
    int? _foundAt;

    _recentsBox.toMap().forEach((key, value) {
      SongModel _song = SongModel(jsonDecode(_recentsBox.get(key)));

      if (_song.id == recentlyPlayed.id) {
        _foundAt = key;
      }
    });

    return _foundAt;
  }
}
