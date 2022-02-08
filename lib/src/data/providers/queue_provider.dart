import 'package:music/src/data/providers/songs_provider.dart';

import '../../data/services/app_shared_preferences.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueueProvider {
  final AppSharedPreferences _preferences = AppSharedPreferences();
  final SongsProvider _songsProvider = SongsProvider();

  Future<List<SongModel>> getQueue() async {
    List<SongModel>? queue = await _preferences.getQueueList();
    queue ??= await _songsProvider.getSongs();
    return queue;
  }
}
