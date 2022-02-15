import '../../../data/models/playlist.dart';
import '../../../global/constants/enums.dart';

class PlaylistsState {
  final List<Playlist> playlists;
  final Status status;
  final Action action;
  const PlaylistsState({
    required this.playlists,
    required this.status,
    required this.action,
  });
}
