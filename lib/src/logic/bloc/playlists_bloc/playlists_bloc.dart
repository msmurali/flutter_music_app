import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:music/src/data/providers/playlists_provider.dart';
import 'package:music/src/data/services/playlist_services.dart';
import '../../../data/models/playlist.dart';
import '../../../global/constants/enums.dart';
import 'bloc.dart';

class PlaylistsBloc extends Bloc<PlaylistsEvent, PlaylistsState> {
  PlaylistsBloc({required PlaylistsState initialState}) : super(initialState) {
    on<CreatePlaylist>(_onCreatePlaylist);
    on<RemovePlaylist>(_onRemovePlaylist);
    on<RenamePlaylist>(_onRenamePlaylist);
  }

  final PlaylistServices _playlistServices = PlaylistServices();
  final PlaylistsProvider _playlistProvider = PlaylistsProvider();

  FutureOr<void> _onCreatePlaylist(
    CreatePlaylist event,
    Emitter<PlaylistsState> emitter,
  ) async {
    String _playlistName = event.playlistName;

    bool _result = await _playlistServices.createPlaylist(_playlistName);

    List<Playlist> _playlists = await _playlistProvider.getPlaylists();

    PlaylistsState _state = PlaylistsState(
      playlists: _playlists,
      status: _result ? Status.succeed : Status.failed,
      action: Action.add,
    );

    emitter.call(_state);
  }

  FutureOr<void> _onRemovePlaylist(
    RemovePlaylist event,
    Emitter<PlaylistsState> emitter,
  ) async {
    String _playlistName = event.playlistName;

    bool _result = await _playlistServices.rmPlaylist(_playlistName);

    List<Playlist> _playlists = await _playlistProvider.getPlaylists();

    PlaylistsState _state = PlaylistsState(
      playlists: _playlists,
      status: _result ? Status.succeed : Status.failed,
      action: Action.remove,
    );

    emitter.call(_state);
  }

  FutureOr<void> _onRenamePlaylist(
    RenamePlaylist event,
    Emitter<PlaylistsState> emitter,
  ) async {
    String _oldName = event.oldName;
    String _newName = event.newName;

    bool _result = await _playlistServices.renamePlaylist(_oldName, _newName);

    List<Playlist> _playlists = await _playlistProvider.getPlaylists();

    PlaylistsState _state = PlaylistsState(
      playlists: _playlists,
      status: _result ? Status.succeed : Status.failed,
      action: Action.rename,
    );

    emitter.call(_state);
  }
}
