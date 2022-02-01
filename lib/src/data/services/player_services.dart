import 'package:music/src/data/services/app_shared_preferences.dart';
import 'package:music/src/global/constants/enums.dart';

class PlayerServices {
  final AppSharedPreferences _preferences = AppSharedPreferences();

  Future<bool> setPlaybackMode(PlaybackMode playbackMode) async {
    return await _preferences.setPlaybackMode(playbackMode.name);
  }

  PlaybackMode getPlaybackMode() {
    String _playbackMode = _preferences.getPlaybackMode();

    if (_playbackMode == PlaybackMode.order.name) {
      return PlaybackMode.order;
    } else if (_playbackMode == PlaybackMode.shuffle.name) {
      return PlaybackMode.shuffle;
    } else {
      return PlaybackMode.repeat;
    }
  }
}
