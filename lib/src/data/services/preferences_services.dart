import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../global/constants/enums.dart';
import 'app_shared_preferences.dart';

class PreferencesServices {
  final AppSharedPreferences _preferences = AppSharedPreferences();

  ThemeMode getTheme() {
    String themeString = _preferences.getAppTheme();
    if (themeString == AppTheme.light.name) {
      return ThemeMode.light;
    } else if (themeString == AppTheme.dark.name) {
      return ThemeMode.dark;
    } else {
      return ThemeMode.system;
    }
  }

  Future<bool> setTheme(ThemeMode appTheme) async {
    return await _preferences.setAppTheme(appTheme.name);
  }

  SongSortType getSongsSortType() {
    String sortTypeString = _preferences.getSongsSortType();
    if (sortTypeString == SongSortType.ALBUM.name) {
      return SongSortType.ALBUM;
    } else if (sortTypeString == SongSortType.ARTIST.name) {
      return SongSortType.ARTIST;
    } else if (sortTypeString == SongSortType.DATE_ADDED.name) {
      return SongSortType.DATE_ADDED;
    } else if (sortTypeString == SongSortType.DISPLAY_NAME.name) {
      return SongSortType.DISPLAY_NAME;
    } else if (sortTypeString == SongSortType.DURATION.name) {
      return SongSortType.DURATION;
    } else if (sortTypeString == SongSortType.SIZE.name) {
      return SongSortType.SIZE;
    } else {
      return SongSortType.TITLE;
    }
  }

  Future<bool> setSongsSortType(SongSortType sortType) async {
    return await _preferences.setSongsSortType(sortType.name);
  }

  OrderType getSongsOrderType() {
    String orderType = _preferences.getSongsSortType();
    if (orderType == OrderType.ASC_OR_SMALLER.name) {
      return OrderType.ASC_OR_SMALLER;
    } else {
      return OrderType.DESC_OR_GREATER;
    }
  }

  Future<bool> setSongsOrderType(OrderType orderType) async {
    return await _preferences.setSongsSortType(orderType.name);
  }

  AlbumSortType getAlbumsSortType() {
    String sortTypeString = _preferences.getAlbumsSortType();
    if (sortTypeString == AlbumSortType.ALBUM.name) {
      return AlbumSortType.ALBUM;
    } else if (sortTypeString == AlbumSortType.ARTIST.name) {
      return AlbumSortType.ARTIST;
    } else {
      return AlbumSortType.NUM_OF_SONGS;
    }
  }

  Future<bool> setAlbumsSortType(AlbumSortType sortType) async {
    return await _preferences.setAlbumsSortType(sortType.name);
  }

  OrderType getAlbumsOrderType() {
    String orderType = _preferences.getAlbumsOrderType();
    if (orderType == OrderType.ASC_OR_SMALLER.name) {
      return OrderType.ASC_OR_SMALLER;
    } else {
      return OrderType.DESC_OR_GREATER;
    }
  }

  Future<bool> setAlbumsOrderType(OrderType orderType) async {
    return await _preferences.setAlbumsOrderType(orderType.name);
  }

  ArtistSortType getArtistsSortType() {
    String sortTypeString = _preferences.getArtistsSortType();
    if (sortTypeString == ArtistSortType.ARTIST.name) {
      return ArtistSortType.ARTIST;
    } else if (sortTypeString == ArtistSortType.NUM_OF_ALBUMS.name) {
      return ArtistSortType.NUM_OF_ALBUMS;
    } else {
      return ArtistSortType.NUM_OF_TRACKS;
    }
  }

  Future<bool> setArtistSortType(ArtistSortType sortType) async {
    return await _preferences.setArtistsSortType(sortType.name);
  }

  OrderType getArtistsOrderType() {
    String orderType = _preferences.getArtistsOrderType();
    if (orderType == OrderType.ASC_OR_SMALLER.name) {
      return OrderType.ASC_OR_SMALLER;
    } else {
      return OrderType.DESC_OR_GREATER;
    }
  }

  Future<bool> setArtistsOrderType(OrderType orderType) async {
    return await _preferences.setArtistsOrderType(orderType.name);
  }

  Future<bool> setView(View viewType) async {
    return await _preferences.setView(viewType.name);
  }

  View getView() {
    final String _view = _preferences.getView();
    return _view == View.list.name ? View.list : View.grid;
  }

  Future<bool> setGridSize(int size) async {
    return await _preferences.setGridSize(size);
  }

  int getGridSize() {
    return _preferences.getGridSize();
  }
}
