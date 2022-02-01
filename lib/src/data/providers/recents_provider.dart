import 'package:music/src/data/services/app_shared_preferences.dart';
import 'package:on_audio_query/on_audio_query.dart';

class RecentsProvider {
  final AppSharedPreferences _preferences = AppSharedPreferences();

  List<SongModel> getRecents() {
    List<SongModel> recents = _preferences.getRecentsList();
    return recents;
  }
}
