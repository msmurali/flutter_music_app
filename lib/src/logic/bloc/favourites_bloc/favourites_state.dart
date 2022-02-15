import 'package:on_audio_query/on_audio_query.dart';

import '../../../global/constants/enums.dart';

class FavouritesState {
  final List<SongModel> songs;
  final Status status;
  final Action action;
  const FavouritesState({
    required this.songs,
    required this.action,
    required this.status,
  });
}
