import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../services/hive_services.dart';

class FavouritesProvider {
  final HiveServices _hiveServices = HiveServices();

  List<SongModel> getFavouritesSongs() {
    Box _favouritesBox = _hiveServices.getFavouritesBox();
    return _favouritesBox
        .toMap()
        .values
        .map((str) => SongModel(jsonDecode(str)))
        .toList();
  }
}
