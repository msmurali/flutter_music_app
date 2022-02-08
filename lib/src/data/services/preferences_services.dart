import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../global/constants/index.dart';
import 'hive_services.dart';

class PreferencesServices {
  final HiveServices _hiveServices = HiveServices();

  ThemeMode getTheme() {
    String _theme = _hiveServices.getPreference(keys[StorageKey.theme]!);
    if (_theme == ThemeMode.light.name) {
      return ThemeMode.light;
    } else if (_theme == ThemeMode.dark.name) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  Future<void> setTheme(ThemeMode theme) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.theme]!,
      theme.name,
    );
  }

  SongSortType getSongSortType() {
    String _songSortType =
        _hiveServices.getPreference(keys[StorageKey.songsSortType]!);
    if (_songSortType == SongSortType.ALBUM.name) {
      return SongSortType.ALBUM;
    } else if (_songSortType == SongSortType.ARTIST.name) {
      return SongSortType.ARTIST;
    } else if (_songSortType == SongSortType.DATE_ADDED.name) {
      return SongSortType.DATE_ADDED;
    } else if (_songSortType == SongSortType.TITLE.name) {
      return SongSortType.TITLE;
    } else if (_songSortType == SongSortType.DURATION.name) {
      return SongSortType.DURATION;
    } else if (_songSortType == SongSortType.SIZE.name) {
      return SongSortType.SIZE;
    } else {
      return SongSortType.DISPLAY_NAME;
    }
  }

  Future<void> setSongSortType(SongSortType songSortType) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.songsSortType]!,
      songSortType.name,
    );
  }

  OrderType getSongOrderType() {
    String _songOrderType =
        _hiveServices.getPreference(keys[StorageKey.songsOrderType]!);
    if (_songOrderType == OrderType.DESC_OR_GREATER.name) {
      return OrderType.DESC_OR_GREATER;
    } else {
      return OrderType.ASC_OR_SMALLER;
    }
  }

  Future<void> setSongOrderType(OrderType songOrderType) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.songsOrderType]!,
      songOrderType.name,
    );
  }

  AlbumSortType getAlbumsSortType() {
    String _albumSortType =
        _hiveServices.getPreference(keys[StorageKey.albumsSortType]!);
    if (_albumSortType == AlbumSortType.ARTIST.name) {
      return AlbumSortType.ARTIST;
    } else if (_albumSortType == AlbumSortType.NUM_OF_SONGS.name) {
      return AlbumSortType.NUM_OF_SONGS;
    } else {
      return AlbumSortType.ARTIST;
    }
  }

  Future<void> setAlbumsSortType(AlbumSortType albumSortType) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.albumsSortType]!,
      albumSortType.name,
    );
  }

  OrderType getAlbumOrderType() {
    String _albumOrderType =
        _hiveServices.getPreference(keys[StorageKey.albumsOrderType]!);
    if (_albumOrderType == OrderType.DESC_OR_GREATER.name) {
      return OrderType.DESC_OR_GREATER;
    } else {
      return OrderType.ASC_OR_SMALLER;
    }
  }

  Future<void> setAlbumOrderType(OrderType _albumOrderType) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.albumsOrderType]!,
      _albumOrderType.name,
    );
  }

  ArtistSortType getArtistSortType() {
    String _artistSortType =
        _hiveServices.getPreference(keys[StorageKey.artistsSortType]!);
    if (_artistSortType == ArtistSortType.NUM_OF_ALBUMS.name) {
      return ArtistSortType.NUM_OF_TRACKS;
    } else if (_artistSortType == ArtistSortType.NUM_OF_ALBUMS.name) {
      return ArtistSortType.NUM_OF_ALBUMS;
    } else {
      return ArtistSortType.ARTIST;
    }
  }

  Future<void> setArtistSortType(ArtistSortType artistSortType) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.artistsSortType]!,
      artistSortType.name,
    );
  }

  OrderType getArtistOrderType() {
    String _artistOrderType =
        _hiveServices.getPreference(keys[StorageKey.artistsOrderType]!);
    if (_artistOrderType == OrderType.DESC_OR_GREATER.name) {
      return OrderType.DESC_OR_GREATER;
    } else {
      return OrderType.ASC_OR_SMALLER;
    }
  }

  Future<void> setArtistOrderType(OrderType artistOrderType) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.artistsOrderType]!,
      artistOrderType.name,
    );
  }

  Future<void> setView(View view) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.view]!,
      view.name,
    );
  }

  View getView() {
    String _view = _hiveServices.getPreference(keys[StorageKey.view]!);
    return _view == View.grid.name ? View.grid : View.list;
  }

  Future<void> setGridSize(int gridSize) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.gridSize]!,
      gridSize.toString(),
    );
  }

  int getGridSize() {
    String _gridSize = _hiveServices.getPreference(
      keys[StorageKey.gridSize]!,
      defaultVal: '3',
    );

    return int.parse(_gridSize);
  }
}
