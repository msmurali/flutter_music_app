import 'package:music/src/data/services/app_shared_preferences.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueueProvider {
  final AppSharedPreferences _preferences = AppSharedPreferences();

  List<SongModel> getQueue() {
    List<SongModel> queue = _preferences.getQueueList();
    return queue;
  }
}
