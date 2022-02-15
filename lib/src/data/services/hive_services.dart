import 'package:hive_flutter/hive_flutter.dart';

import '../../global/constants/index.dart';

class HiveServices {
  HiveServices._();

  static final HiveServices instance = HiveServices._();

  factory HiveServices() {
    return instance;
  }

  final String _recentsKey = keys[StorageKey.recents]!;
  final String _preferencesKey = keys[StorageKey.preferences]!;
  final String _queueKey = keys[StorageKey.queue]!;
  final String _queueIndexKey = keys[StorageKey.queueIndex]!;
  final String _favouritesKey = keys[StorageKey.favourites]!;
  final String _playlistsKey = keys[StorageKey.playlists]!;

  Future<void> init() async {
    await Hive.initFlutter();
    await initRecentsBox();
    await initFavouritesBox();
    await initPlaylistsBox();
    await initPreferencesBox();
    await initQueueBox();
  }

  /* Recents */
  Future<Box> initRecentsBox() async {
    return await Hive.openBox(
      _recentsKey,
    );
  }

  Box getRecentsBox() {
    return Hive.box(_recentsKey);
  }

  Future<void> addToRecentsBox(String str) async {
    await Hive.box(_recentsKey).add(str);
  }

  Future<void> rmOldestFromRecentsBox() async {
    Box _recentsBox = Hive.box(_recentsKey);
    int _key = _recentsBox.keyAt(0);
    await _recentsBox.delete(_key);
  }

  Future<void> rmFromRecentsBox(int key) async {
    Box _recentsBox = Hive.box(_recentsKey);
    await _recentsBox.delete(key);
  }

  Future<int> clearRecentsBox() async {
    return await Hive.box(_recentsKey).clear();
  }

  /* Favourites */
  Future<Box> initFavouritesBox() async {
    return await Hive.openBox(
      _favouritesKey,
    );
  }

  Box getFavouritesBox() {
    return Hive.box(_favouritesKey);
  }

  Future<void> addToFavouritesBox(int key, String value) async {
    Box _favouritesBox = Hive.box(_favouritesKey);
    await _favouritesBox.put(key, value);
  }

  Future<void> addAllToFavourites(List<int> keys, List<String> values) async {
    Box _favouritesBox = Hive.box(_favouritesKey);
    for (int indx = 0; indx < keys.length; indx++) {
      await _favouritesBox.put(keys[indx], values[indx]);
    }
  }

  Future<void> rmFromFavouritesBox(int key) async {
    Box _favouritesBox = Hive.box(_favouritesKey);
    await _favouritesBox.delete(key);
  }

  Future<void> clearFavouritesBox() async {
    Box _favouritesBox = Hive.box(_favouritesKey);
    await _favouritesBox.clear();
  }

  /* Playlists */
  Future<Box> initPlaylistsBox() async {
    return await Hive.openBox(
      _playlistsKey,
    );
  }

  Box getPlaylistsBox() {
    return Hive.box(_playlistsKey);
  }

  Future<void> createPlaylist(String name, {Map<int, String>? encodedSongs}) async {
    Box _playlistsBox = Hive.box(_playlistsKey);
    await _playlistsBox.put(name, encodedSongs ?? <int, String>{});
  }

  Future<void> rmPlaylist(String name) async {
    Box _playlistsBox = Hive.box(_playlistsKey);
    await _playlistsBox.delete(name);
  }

  Future<void> addToPlaylist(String playlistName, int key, String value) async {
    Box _playlistsBox = Hive.box(_playlistsKey);
    Map<int, String> _playlist = _playlistsBox.get(playlistName);
    _playlist[key] = value;
    await _playlistsBox.put(playlistName, _playlist);
  }

  Future<void> rmFromPlaylist(String playlistName, int key) async {
    Box _playlistsBox = Hive.box(_playlistsKey);
    Map<int, String> _playlist = _playlistsBox.get(playlistName);
    _playlist.remove(key);
    await _playlistsBox.put(playlistName, _playlist);
  }

  Future<void> addAllToPlaylist(
      String playlistName, List<int> keys, List<String> values) async {
    Box _playlistsBox = Hive.box(_playlistsKey);
    Map<int, String> _playlist = _playlistsBox.get(playlistName);
    for (int indx = 0; indx < keys.length; indx++) {
      _playlist[keys[indx]] = values[indx];
    }
    await _playlistsBox.put(playlistName, _playlist);
  }

  Future<void> clearPlaylist(String playlistName) async {
    Box _playlistsBox = Hive.box(_playlistsKey);
    await _playlistsBox.put(playlistName, <int, String>{});
  }

  Future<void> clearPlaylistsBox() async {
    Box _playlistsBox = Hive.box(_playlistsKey);
    await _playlistsBox.clear();
  }

  /* Preferences */
  Future<Box> initPreferencesBox() async {
    return await Hive.openBox(_preferencesKey);
  }

  Box getPreferencesBox() {
    return Hive.box(_preferencesKey);
  }

  Future<void> setPreferenceToBox(String key, String value) async {
    Box _preferencesBox = Hive.box(_preferencesKey);
    return await _preferencesBox.put(key, value);
  }

  String? getPreference(String key, {dynamic defaultVal}) {
    Box _preferencesBox = Hive.box(_preferencesKey);
    if (defaultVal != null) {
      return _preferencesBox.get(key, defaultValue: defaultVal);
    }
    return _preferencesBox.get(key);
  }

  /* Queue */
  Future<Box> initQueueBox() async {
    return await Hive.openBox(_queueKey);
  }

  Box getQueueBox() {
    return Hive.box(_queueKey);
  }

  List<String>? getQueue() {
    Box _queueBox = Hive.box(_queueKey);
    return _queueBox.get(_queueKey);
  }

  Future<void> setQueue(List<String> queue) async {
    Box _queueBox = Hive.box(_queueKey);
    return await _queueBox.put(_queueKey, queue);
  }

  int? getQueueIndex() {
    Box _queueBox = Hive.box(_queueKey);
    return _queueBox.get(_queueIndexKey);
  }

  Future<void> setQueueIndex(int index) async {
    Box _queueBox = Hive.box(_queueKey);
    return await _queueBox.put(_queueIndexKey, index);
  }
}
