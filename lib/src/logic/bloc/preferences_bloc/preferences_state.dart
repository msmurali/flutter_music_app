import 'package:music/src/global/constants/enums.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PreferencesState {
  final SongSortType songsSortType;
  final OrderType songsOrderType;
  final ArtistSortType artistsSortType;
  final OrderType albumsOrderType;
  final AlbumSortType albumsSortType;
  final OrderType artistsOrderType;
  final View view;
  final int gridSize;

  const PreferencesState({
    required this.albumsSortType,
    required this.albumsOrderType,
    required this.artistsSortType,
    required this.artistsOrderType,
    required this.songsSortType,
    required this.songsOrderType,
    required this.view,
    required this.gridSize,
  });
}
