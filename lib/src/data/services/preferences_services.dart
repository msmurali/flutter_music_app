import 'package:music/src/data/services/app_shared_preferences.dart';
import 'package:music/src/global/constants/enums.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PreferencesServices {
  final AppSharedPreferences _preferences = AppSharedPreferences();

  AppThemes getTheme() {
    String themeString = _preferences.getAppTheme();
    if (themeString == AppThemes.light.name) {
      return AppThemes.light;
    } else if (themeString == AppThemes.dark.name) {
      return AppThemes.dark;
    } else {
      return AppThemes.system;
    }
  }

  Future<bool> setTheme(AppThemes appTheme) async {
    return await _preferences.setAppTheme(appTheme.name);
  }

  SongSortType getSongSortType() {
    String sortTypeString = _preferences.getSortType();
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

  Future<bool> setSongSortType(SongSortType sortType) async {
    return await _preferences.setSortType(sortType.name);
  }

  Future<bool> setView(View viewType) async {
    return await _preferences.setView(viewType.name);
  }

  View getView() {
    final String _view = _preferences.getView();
    return _view == View.list.name ? View.list : View.grid;
  }
}
