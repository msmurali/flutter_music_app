import 'package:on_audio_query/on_audio_query.dart';

class PreferencesEvent {
  const PreferencesEvent();
}

class SetListView extends PreferencesEvent {
  const SetListView();
}

class SetGridView extends PreferencesEvent {
  const SetGridView();
}

class ChangeGridSize extends PreferencesEvent {
  final int size;
  const ChangeGridSize({required this.size});
}

class ChangeSongSortType extends PreferencesEvent {
  final SongSortType sortType;
  const ChangeSongSortType({required this.sortType});
}

class ChangeSongOrderType extends PreferencesEvent {
  final OrderType orderType;
  const ChangeSongOrderType({required this.orderType});
}

class ChangeAlbumSortType extends PreferencesEvent {
  final AlbumSortType sortType;
  const ChangeAlbumSortType({required this.sortType});
}

class ChangeAlbumOrderType extends PreferencesEvent {
  final OrderType orderType;
  const ChangeAlbumOrderType({required this.orderType});
}

class ChangeArtistSortType extends PreferencesEvent {
  final ArtistSortType sortType;
  const ChangeArtistSortType({required this.sortType});
}

class ChangeArtistOrderType extends PreferencesEvent {
  final OrderType orderType;
  const ChangeArtistOrderType({required this.orderType});
}
