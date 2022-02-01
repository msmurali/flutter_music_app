import 'package:on_audio_query/on_audio_query.dart';

class PreferencesEvent {
  const PreferencesEvent();
}

class ChangeSongSortType extends PreferencesEvent {
  final SongSortType sortType;
  const ChangeSongSortType({required this.sortType});
}

class ChangeSortingOrderType extends PreferencesEvent {
  final OrderType orderType;
  const ChangeSortingOrderType({required this.orderType});
}
