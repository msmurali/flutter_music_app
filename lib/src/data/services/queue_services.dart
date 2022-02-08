import '../providers/songs_provider.dart';
import 'app_shared_preferences.dart';
import 'package:on_audio_query/on_audio_query.dart';

class QueueServices {
  final SongsProvider _songsProvider = SongsProvider();
  final AppSharedPreferences _preferences = AppSharedPreferences();

  Future<bool> createQueue() async {
    List<SongModel> songs = await _songsProvider.getSongs();
    return await _preferences.setQueueList(songs);
  }

  Future<bool> queueAlreadyExists() async {
    final List<SongModel>? _queue = await _preferences.getQueueList();
    return _queue != null ? true : false;
  }
}
