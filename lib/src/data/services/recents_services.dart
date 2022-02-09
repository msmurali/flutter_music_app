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
      int? _foundAt = songAlreadyInRecents(recentlyPlayed);
      if (_foundAt != null) {
        String str = _recentsProvider.getFromRecents(_foundAt);
        await _hiveServices.rmFromRecentsBox(_foundAt);
        await _hiveServices.addToRecentsBox(str);
      } else {
        if (_recentsBox.length + 1 > recentsListSize) {
          await _hiveServices.rmFirstKeyFromRecentsBox();
        }
        await _hiveServices.addToRecentsBox(json.encode(recentlyPlayed.getMap));
      }
    }
  }

  Future<void> rmFromRecents({int? key}) async {
    if (key != null) {
      return await _hiveServices.rmFromRecentsBox(key);
    } else {
      return await _hiveServices.rmFirstKeyFromRecentsBox();
    }
  }

  int? songAlreadyInRecents(SongModel recentlyPlayed) {
    int? _foundAt;

    Box _recentsBox = _hiveServices.getRecentsBox();

    Map<dynamic, dynamic> _recentsMap = _recentsBox.toMap();

    _recentsMap.keys.map((key) {
      SongModel _song = SongModel(jsonDecode(_recentsMap[key]));
      if (recentlyPlayed.id == _song.id) {
        _foundAt = int.parse(key);
      }
    });

    return _foundAt;
  }
}
