import 'package:on_audio_query/on_audio_query.dart';

enum FavStatus {
  added,
  removed,
  none,
}

enum FavAction {
  add,
  remove,
  none,
}

class FavouritesState {
  final List<SongModel> songs;
  final FavStatus status;
  final FavAction action;
  const FavouritesState({
    required this.songs,
    required this.action,
    required this.status,
  });
}
