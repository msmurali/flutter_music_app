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

  Future<void> init() async {
    await Hive.initFlutter();
    await initRecentsBox();
    await initPreferencesBox();
    await initQueueBox();
  }

  /* Recents */
  Future<Box> initRecentsBox() async {
    return await Hive.openBox(_recentsKey);
  }

  Box getRecentsBox() {
    return Hive.box(_recentsKey);
  }

  Future<void> addToRecentsBox(String key, String str) async {
    return await Hive.box(_recentsKey).put(key, str);
  }

  Future<void> rmOldestFromRecentsBox() async {
    Box _recentsBox = Hive.box(_recentsKey);
    String _key = _recentsBox.keyAt(_recentsBox.length - 1);
    await _recentsBox.delete(_key);
  }

  Future<void> rmFromRecentsBox(String key) async {
    Box _recentsBox = Hive.box(_recentsKey);
    await _recentsBox.delete(key);
  }

  Future<int> clearRecentsBox() async {
    return await Hive.box(_recentsKey).clear();
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
