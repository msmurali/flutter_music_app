import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../services/hive_services.dart';

class RecentsProvider {
  final HiveServices _hiveServices = HiveServices();

  List<SongModel> getRecents() {
    Box _recentsBox = _hiveServices.getRecentsBox();

    List<SongModel> _recents = _recentsBox.values.map((str) {
      return SongModel(jsonDecode(str));
    }).toList();

    return _recents.reversed.toList();
  }

  String getFromRecents(int key) {
    Box _recentsBox = _hiveServices.getRecentsBox();
    return _recentsBox.get(key);
  }
}
