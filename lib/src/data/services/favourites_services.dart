import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'hive_services.dart';

class FavouritesServices {
  final HiveServices _hiveServices = HiveServices();

  Future<void> createFavourites() async {
    await _hiveServices.initFavouritesBox();
  }

  bool songAlreadyExistsInFavourites(SongModel song) {
    Box _favouritesBox = _hiveServices.getFavouritesBox();
    return _favouritesBox.toMap().keys.contains(song.id);
  }

  Future<bool> addToFavourites(SongModel song) async {
    if (songAlreadyExistsInFavourites(song)) {
      return false;
    }
    await _hiveServices.addToFavouritesBox(song.id, jsonEncode(song.getMap));
    return true;
  }

  Future<void> addAllToFavourites(List<SongModel> songs) async {
    for (int indx = 0; indx < songs.length; indx++) {
      await addToFavourites(songs[indx]);
    }
  }

  Future<bool> rmFromFavourites(SongModel song) async {
    await _hiveServices.rmFromFavouritesBox(song.id);
    return !_hiveServices.getFavouritesBox().containsKey(song.id);
  }

  Future<void> clearFavourites() async {
    await _hiveServices.clearFavouritesBox();
  }
}
