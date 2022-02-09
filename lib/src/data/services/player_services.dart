import '../../global/constants/index.dart';
import 'hive_services.dart';

class PlayerServices {
  final HiveServices _hiveServices = HiveServices();

  Future<void> setPlaybackMode(PlaybackMode playbackMode) async {
    return await _hiveServices.setPreferenceToBox(
      keys[StorageKey.playbackMode]!,
      playbackMode.name,
    );
  }

  PlaybackMode getPlaybackMode() {
    String? _playbackMode =
        _hiveServices.getPreference(keys[StorageKey.playbackMode]!);

    if (_playbackMode == PlaybackMode.repeat.name) {
      return PlaybackMode.repeat;
    } else if (_playbackMode == PlaybackMode.shuffle.name) {
      return PlaybackMode.shuffle;
    } else {
      return PlaybackMode.order;
    }
  }
}
