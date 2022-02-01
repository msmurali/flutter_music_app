import 'package:music/src/data/services/app_shared_preferences.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PreferencesState {
  final SongSortType sortType;
  final OrderType orderType;

  const PreferencesState({
    required this.sortType,
    required this.orderType,
  });
}
