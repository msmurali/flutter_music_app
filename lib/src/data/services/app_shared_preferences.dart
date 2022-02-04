import 'dart:convert';
import 'package:flutter/material.dart' show ThemeMode;
import 'package:on_audio_query/on_audio_query.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../global/constants/index.dart';

class AppSharedPreferences {
  static late SharedPreferences preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  /* recents list */
  Future<bool> setRecentsList(List<SongModel> songsList) async {
    final String _key = keys[StorageKey.recents]!;

    List<String> _songMapStringList =
        songsList.map((song) => json.encode(song.getMap)).toList();

    return await preferences.setStringList(_key, _songMapStringList);
  }

  List<SongModel>? getRecentsList() {
    final String _key = keys[StorageKey.recents]!;

    List<String>? _songMapStringList = preferences.getStringList(_key);

    if (_songMapStringList == null) {
      return null;
    }

    return _songMapStringList
        .map((songMapString) => SongModel(jsonDecode(songMapString)))
        .toList();
  }

  /* Queue list */
  Future<bool> setQueueList(List<SongModel> songsList) async {
    final String _key = keys[StorageKey.queue]!;

    final List<String> _songMapStringList =
        songsList.map((song) => json.encode(song.getMap)).toList();

    return await preferences.setStringList(_key, _songMapStringList);
  }

  List<SongModel>? getQueueList() {
    final String _key = keys[StorageKey.queue]!;
    final List<String>? _songMapStringList = preferences.getStringList(_key);

    if (_songMapStringList == null) {
      return null;
    }

    return _songMapStringList
        .map((songMapString) => SongModel(jsonDecode(songMapString)))
        .toList();
  }

  /* Queue Index */
  Future<bool> setQueueIndex(int index) async {
    final String _key = keys[StorageKey.queueIndex]!;
    return await preferences.setInt(_key, index);
  }

  int getQueueIndex() {
    final String _key = keys[StorageKey.queueIndex]!;
    return preferences.getInt(_key) ?? 0;
  }

  /* Playback Mode */
  Future<bool> setPlaybackMode(String playbackMode) async {
    final String _key = keys[StorageKey.playback]!;
    return await preferences.setString(_key, playbackMode);
  }

  String getPlaybackMode() {
    final String _key = keys[StorageKey.playback]!;
    return preferences.getString(_key) ?? PlaybackMode.order.name;
  }

  /* Theme */
  Future<bool> setAppTheme(String theme) async {
    final String _key = keys[StorageKey.theme]!;
    return await preferences.setString(_key, theme);
  }

  String getAppTheme() {
    final String _key = keys[StorageKey.theme]!;
    return preferences.getString(_key) ?? ThemeMode.light.name;
  }

  /* Song Sort Type */
  Future<bool> setSongsSortType(String sortType) async {
    final String _key = keys[StorageKey.songsSortType]!;
    return await preferences.setString(_key, sortType);
  }

  String getSongsSortType() {
    final String _key = keys[StorageKey.songsSortType]!;
    return preferences.getString(_key) ?? SongSortType.DISPLAY_NAME.name;
  }

  /* Song Order Type */
  Future<bool> setSongsOrderType(String orderType) async {
    final String _key = keys[StorageKey.songsOrderType]!;
    return await preferences.setString(_key, orderType);
  }

  String getSongsOrderType() {
    final String _key = keys[StorageKey.songsOrderType]!;
    return preferences.getString(_key) ?? OrderType.ASC_OR_SMALLER.name;
  }

  /* Artist Sort Type */
  Future<bool> setArtistsSortType(String sortType) async {
    final String _key = keys[StorageKey.artistsSortType]!;
    return await preferences.setString(_key, sortType);
  }

  String getArtistsSortType() {
    final String _key = keys[StorageKey.artistsSortType]!;
    return preferences.getString(_key) ?? ArtistSortType.ARTIST.name;
  }

  /* Artist Order Type */
  Future<bool> setArtistsOrderType(String orderType) async {
    final String _key = keys[StorageKey.artistsOrderType]!;
    return await preferences.setString(_key, orderType);
  }

  String getArtistsOrderType() {
    final String _key = keys[StorageKey.artistsOrderType]!;
    return preferences.getString(_key) ?? OrderType.ASC_OR_SMALLER.name;
  }

  /* Album Sort Type */
  Future<bool> setAlbumsSortType(String sortType) async {
    final String _key = keys[StorageKey.albumsSortType]!;
    return await preferences.setString(_key, sortType);
  }

  String getAlbumsSortType() {
    final String _key = keys[StorageKey.albumsSortType]!;
    return preferences.getString(_key) ?? AlbumSortType.ALBUM.name;
  }

  /* Album Order Type */
  Future<bool> setAlbumsOrderType(String orderType) async {
    final String _key = keys[StorageKey.albumsOrderType]!;
    return await preferences.setString(_key, orderType);
  }

  String getAlbumsOrderType() {
    final String _key = keys[StorageKey.albumsOrderType]!;
    return preferences.getString(_key) ?? OrderType.ASC_OR_SMALLER.name;
  }

  /* view */
  Future<bool> setView(String view) async {
    final String _key = keys[StorageKey.view]!;
    return await preferences.setString(_key, view);
  }

  String getView() {
    final String _key = keys[StorageKey.view]!;
    return preferences.getString(_key) ?? View.list.name;
  }

  /* grid size */
  Future<bool> setGridSize(int size) async {
    final String _key = keys[StorageKey.gridSize]!;
    return await preferences.setInt(_key, size);
  }

  int getGridSize() {
    final String _key = keys[StorageKey.gridSize]!;
    return preferences.getInt(_key) ?? 3;
  }
}
