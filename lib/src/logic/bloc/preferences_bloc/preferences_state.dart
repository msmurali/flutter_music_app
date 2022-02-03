import 'package:music/src/global/constants/enums.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PreferencesState {
  final SongSortType sortType;
  final OrderType orderType;
  final View view;
  final int gridSize;

  const PreferencesState({
    required this.sortType,
    required this.orderType,
    required this.view,
    required this.gridSize,
  });
}
