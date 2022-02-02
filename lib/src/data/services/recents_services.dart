import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/constants.dart';
import '../providers/recents_provider.dart';
import 'app_shared_preferences.dart';

class RecentsServices {
  final AppSharedPreferences _preferences = AppSharedPreferences();
  final RecentsProvider _recentsProvider = RecentsProvider();

  Future<bool> createRecents() async {
    return await _preferences.setRecentsList([]);
  }

  bool recentsAlreadyExists() {
    final List<SongModel>? _recents = _preferences.getRecentsList();
    return _recents != null ? true : false;
  }

  Future<bool> addToRecents(SongModel recentlyPlayed) async {
    List<SongModel> _recents = _recentsProvider.getRecents();

    if (_recents.isEmpty) {
      _recents.add(recentlyPlayed);
    } else {
      int? _foundAt = songAlreadyInRecents(recentlyPlayed);
      if (_foundAt != null) {
        _recents.add(_recents.removeAt(_foundAt));
      } else {
        if (_recents.length + 1 > recentsListSize) {
          await rmFromRecents();
          _recents = _recentsProvider.getRecents();
          _recents.add(recentlyPlayed);
        } else {
          _recents.add(recentlyPlayed);
        }
      }
    }

    return await _preferences.setRecentsList(_recents);
  }

  Future<bool> rmFromRecents() async {
    List<SongModel> _recents = _recentsProvider.getRecents();
    _recents.removeAt(0);
    return await _preferences.setRecentsList(_recents);
  }

  int? songAlreadyInRecents(SongModel recentlyPlayed) {
    List<SongModel> _recents = _recentsProvider.getRecents();
    int? _foundAt;

    for (var index = 0; index < _recents.length; index++) {
      if (_recents[index].id == recentlyPlayed.id) {
        _foundAt = index;
        break;
      }
    }

    return _foundAt;
  }
}
