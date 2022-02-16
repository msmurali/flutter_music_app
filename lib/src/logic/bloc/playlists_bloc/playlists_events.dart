import 'package:on_audio_query/on_audio_query.dart';

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

class AddToPlaylist extends PlaylistsEvent {
  final SongModel song;
  final String playlistName;
  AddToPlaylist({required this.song, required this.playlistName});
}

class RemoveFromPlaylist extends PlaylistsEvent {
  final SongModel song;
  final String playlistName;
  RemoveFromPlaylist({required this.song, required this.playlistName});
}

class AddAllToPlaylist extends PlaylistsEvent {
  final dynamic entity;
  final String playlistName;
  AddAllToPlaylist({required this.entity, required this.playlistName});
}
