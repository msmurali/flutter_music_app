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
      _hiveServices.addToRecentsBox(recentlyPlayed.id.toString(), str);
    } else {
      String? _key = songAlreadyInRecents(recentlyPlayed);
      if (_key != null) {
        String str = _recentsProvider.getFromRecents(_key);
        await _hiveServices.rmFromRecentsBox(_key);
        await _hiveServices.addToRecentsBox(_key, str);
      } else {
        if (_recentsBox.length + 1 > recentsListSize) {
          await _hiveServices.rmOldestFromRecentsBox();
        }
        await _hiveServices.addToRecentsBox(
          recentlyPlayed.id.toString(),
          json.encode(recentlyPlayed.getMap),
        );
      }
    }
  }

  Future<void> rmFromRecents({String? key}) async {
    if (key != null) {
      return await _hiveServices.rmFromRecentsBox(key);
    } else {
      return await _hiveServices.rmOldestFromRecentsBox();
    }
  }

  String? songAlreadyInRecents(SongModel recentlyPlayed) {
    // String? _foundAt;

    Box _recentsBox = _hiveServices.getRecentsBox();

    String _id = recentlyPlayed.id.toString();

    if (_recentsBox.containsKey(_id)) {
      return _id;
    }

    return null;

    // Map<dynamic, dynamic> _recentsMap = _recentsBox.toMap();

    // _recentsMap.keys.map((key) {
    //   print('inside map');
    //   SongModel _song = SongModel(jsonDecode(_recentsMap[key]));
    //   // print(_song.id);
    //   if (recentlyPlayed.id == _song.id) {
    //     _foundAt = int.parse(key);
    //   }
    // });

    // return _foundAt;
  }
}
