import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../data/models/playlist.dart';
import '../../logic/bloc/playlists_bloc/bloc.dart';
import '../utils/helpers.dart';
import 'playlist_form.dart';

class PlaylistsDialog extends StatelessWidget {
  final dynamic entity;
  const PlaylistsDialog({Key? key, required this.entity}) : super(key: key);

  List<Widget> _getPlaylists(BuildContext context) {
    List<Playlist> playlists =
        BlocProvider.of<PlaylistsBloc>(context).state.playlists;

    return playlists
        .map((playlist) => SizedBox(
              width: double.infinity,
              child: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      Theme.of(context).textButtonTheme.style!.backgroundColor,
                  foregroundColor:
                      Theme.of(context).textButtonTheme.style!.foregroundColor,
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        4.0,
                      ),
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    playlist.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                onPressed: () => _addToPlaylist(context, playlist.name),
              ),
            ))
        .toList();
  }

  void _addToPlaylist(BuildContext context, String playlistName) {
    if (entity is SongModel) {
      BlocProvider.of<PlaylistsBloc>(context).add(
        AddToPlaylist(
          song: entity as SongModel,
          playlistName: playlistName,
        ),
      );
    } else if (entity is AlbumModel) {
      BlocProvider.of<PlaylistsBloc>(context).add(
        AddAllToPlaylist(
          entity: entity as AlbumModel,
          playlistName: playlistName,
        ),
      );
    } else {
      BlocProvider.of<PlaylistsBloc>(context).add(
        AddAllToPlaylist(
          entity: entity as ArtistModel,
          playlistName: playlistName,
        ),
      );
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      elevation: 10.0,
      alignment: Alignment.bottomCenter,
      contentPadding: const EdgeInsets.all(8.0),
      insetPadding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 16.0,
      ),
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: BlocBuilder<PlaylistsBloc, PlaylistsState>(
            builder: (context, state) {
              return SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    ..._getPlaylists(context),
                  ],
                ),
              );
            },
          ),
        ),
        TextButton(
          onPressed: () => showFormDialog(
            context: context,
            form: PlaylistCreationForm(),
          ),
          child: const Text(
            'Create playlist',
          ),
          style: Theme.of(context).textButtonTheme.style,
        ),
      ],
    );
  }
}
