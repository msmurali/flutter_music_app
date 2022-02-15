class PlaylistsEvent {
  const PlaylistsEvent();
}

class CreatePlaylist extends PlaylistsEvent {
  final String playlistName;
  const CreatePlaylist({
    required this.playlistName,
  });
}

class RemovePlaylist extends PlaylistsEvent {
  final String playlistName;
  const RemovePlaylist({
    required this.playlistName,
  });
}

class RenamePlaylist extends PlaylistsEvent {
  final String oldName;
  final String newName;
  const RenamePlaylist({
    required this.oldName,
    required this.newName,
  });
}
