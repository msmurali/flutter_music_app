import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../services/hive_services.dart';

class RecentsProvider {
  final HiveServices _hiveServices = HiveServices();

  List<SongModel> getRecents() {
    Box _recentsBox = _hiveServices.getRecentsBox();

    List<Map<dynamic, dynamic>> _values = _recentsBox.values
        .map((str) => jsonDecode(str) as Map<dynamic, dynamic>)
        .toList();

    _values.sort((a, b) =>
        DateTime.parse(a['time']).compareTo(DateTime.parse(b['time'])) * -1);

    return _values.map((elem) => SongModel(elem['song'])).toList();
  }
}
