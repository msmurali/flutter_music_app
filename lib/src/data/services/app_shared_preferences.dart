import 'dart:convert';
import 'package:music/src/global/constants/constants.dart';
import 'package:music/src/global/constants/enums.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreferences {
  late SharedPreferences preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  /* recents list */
  Future<bool> setRecentsList(List<SongModel> songsList) async {
    final String _key = keys[PreferencesKey.recents]!;

    List<String> _songMapStringList =
        songsList.map((song) => json.encode(song.getMap)).toList();

    return await preferences.setStringList(_key, _songMapStringList);
  }

  List<SongModel> getRecentsList() {
    final String _key = keys[PreferencesKey.recents]!;

    List<String> _songMapStringList = preferences.getStringList(_key)!;

    return _songMapStringList
        .map((songMapString) => SongModel(jsonDecode(songMapString)))
        .toList();
  }

  /* Queue list */
  Future<bool> setQueueList(List<SongModel> songsList) async {
    final String _key = keys[PreferencesKey.queue]!;

    final List<String> _songMapStringList =
        songsList.map((song) => json.encode(song.getMap)).toList();

    return await preferences.setStringList(_key, _songMapStringList);
  }

  List<SongModel> getQueueList() {
    final String _key = keys[PreferencesKey.queue]!;
    final List<String> _songMapStringList = preferences.getStringList(_key)!;

    return _songMapStringList
        .map((songMapString) => SongModel(jsonDecode(songMapString)))
        .toList();
  }

  /* Queue Index */
  Future<bool> setQueueIndex(int index) async {
    final String _key = keys[PreferencesKey.queueIndex]!;
    return await preferences.setInt(_key, index);
  }

  int getQueueIndex() {
    final String _key = keys[PreferencesKey.queueIndex]!;
    return preferences.getInt(_key) ?? 0;
  }

  /* Playback Mode */
  Future<bool> setPlaybackMode(String playbackMode) async {
    final String _key = keys[PreferencesKey.playback]!;
    return await preferences.setString(_key, playbackMode);
  }

  String getPlaybackMode() {
    final String _key = keys[PreferencesKey.playback]!;
    return preferences.getString(_key) ?? PlaybackMode.order.name;
  }

  /* Theme */
  Future<bool> setAppTheme(String theme) async {
    final String _key = keys[PreferencesKey.theme]!;
    return await preferences.setString(_key, theme);
  }

  String getAppTheme() {
    final String _key = keys[PreferencesKey.theme]!;
    return preferences.getString(_key) ?? AppThemes.light.name;
  }

  /* Sort Type */
  Future<bool> setSortType(String sortType) async {
    final String _key = keys[PreferencesKey.sortType]!;
    return await preferences.setString(_key, sortType);
  }

  String getSortType() {
    final String _key = keys[PreferencesKey.sortType]!;
    return preferences.getString(_key) ?? SongSortType.DISPLAY_NAME.name;
  }

  /* view */
  Future<bool> setView(String view) async {
    final String _key = keys[PreferencesKey.view]!;
    return await preferences.setString(_key, view);
  }

  String getView() {
    final String _key = keys[PreferencesKey.view]!;
    return preferences.getString(_key) ?? View.list.name;
  }
}
