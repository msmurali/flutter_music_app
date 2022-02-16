import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/src/interface/widgets/playlists_dialog.dart';
import 'package:music/src/logic/bloc/playlists_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../data/models/playlist.dart';
import '../../data/providers/playlists_provider.dart';
import '../../data/providers/songs_provider.dart';
import '../../data/services/favourites_services.dart';
import '../../global/constants/index.dart';
import '../../logic/bloc/favourites_bloc/bloc.dart';
import '../../logic/bloc/player_bloc/bloc.dart';
import '../widgets/playlist_form.dart';

final FavouritesServices _favouritesServices = FavouritesServices();
final SongsProvider _songsProvider = SongsProvider();

Future<void> showMenuDialog(
  BuildContext context,
  dynamic details,
  Object? arguments,
  List<Option> options,
) async {
  double dx = details.globalPosition.dx;
  double dy = details.globalPosition.dy;

  RelativeRect position = RelativeRect.fromLTRB(dx, dy, dx, dy);

  TextStyle _textStyle = Theme.of(context).textTheme.bodyText2!;

  await showMenu<Option>(
    context: context,
    position: position,
    items: options
        .map(
          (opt) => PopupMenuItem<Option>(
            child: Text(
              optionsText[opt]!,
              style: _textStyle,
            ),
            value: opt,
          ),
        )
        .toList(),
  ).then((value) async {
    if (value == Option.playNext) {
      _addToQueue(context, arguments);
    } else if (value == Option.info) {
      _navigateToInfoScreen(context, arguments);
    } else if (value == Option.addToFavourites) {
      _markAsFavourite(context, arguments);
    } else if (value == Option.addToPlaylist) {
      _showPlaylistsDialog(context, arguments);
    } else if (value == Option.addAllToPlaylist) {
      _showPlaylistsDialog(context, arguments);
    } else if (value == Option.addAllToFavourites) {
      _addAllToFavourites(context, arguments);
    } else if (value == Option.removeFromFavourites) {
      _markAsNotFavourite(context, arguments);
    } else if (value == Option.removeFromPlaylist) {
      _removeFromPlaylist(context, arguments);
    } else if (value == Option.removePlaylist) {
      _removePlaylist(context, arguments);
    }
    return;
  });
}

void _addToQueue(BuildContext context, dynamic entity) {
  SongModel _song = entity as SongModel;
  BlocProvider.of<PlayerBloc>(context).add(
    AddSongNextToNowPlaying(
      song: _song,
    ),
  );
}

void _navigateToInfoScreen(BuildContext context, dynamic entity) {
  Navigator.pushNamed(
    context,
    routes[Routes.infoRoute]!,
    arguments: entity,
  );
}

void _markAsFavourite(BuildContext context, dynamic entity) {
  final SongModel _song = entity as SongModel;
  FavouritesBloc _favBloc = BlocProvider.of<FavouritesBloc>(context);
  _favBloc.add(MarkAsFavourite(song: _song));
}

void _markAsNotFavourite(
  BuildContext context,
  dynamic entity,
) {
  final SongModel _song = entity as SongModel;
  FavouritesBloc _favBloc = BlocProvider.of<FavouritesBloc>(context);
  _favBloc.add(MarkAsNotFavourite(song: _song));
}

Future<void> _addAllToFavourites(BuildContext context, dynamic entity) async {
  late List<SongModel> songs;

  if (entity is AlbumModel) {
    songs = await _songsProvider.getAlbumSongs(entity.album);
  } else if (entity is ArtistModel) {
    songs = await _songsProvider.getArtistSongs(entity.artist);
  }

  if (songs.length > 1) {
    await _favouritesServices.addAllToFavourites(
      songs.sublist(0, songs.length - 1),
    );
  }

  _markAsFavourite(context, songs[songs.length - 1]);
}

Future<void> _removePlaylist(BuildContext context, dynamic playlist) async {
  String playlistName = playlist.name;
  BlocProvider.of<PlaylistsBloc>(context).add(
    RemovePlaylist(
      playlistName: playlistName,
    ),
  );
}

void _removeFromPlaylist(BuildContext context, Object? arguments) {
  Map<dynamic, dynamic> map = arguments as Map<dynamic, dynamic>;

  String _playlistName = map['playlistName'];

  SongModel _song = map['song'];

  BlocProvider.of<PlaylistsBloc>(context).add(
    RemoveFromPlaylist(
      playlistName: _playlistName,
      song: _song,
    ),
  );

  final PlaylistsProvider _playlistsProvider = PlaylistsProvider();

  final Playlist _playlist = _playlistsProvider.getPlaylist(_playlistName);

  Navigator.popAndPushNamed(
    context,
    routes[Routes.songsRoute]!,
    arguments: _playlist,
  );
}

Future<void> _showPlaylistsDialog(
  BuildContext context,
  dynamic entity,
) async {
  await showDialog(
    barrierColor: Colors.black26,
    context: context,
    builder: (BuildContext context) {
      return PlaylistsDialog(
        entity: entity,
      );
    },
  );
}

Future<void> showFormDialog(BuildContext context) async {
  await showDialog(
    barrierColor: Colors.black26,
    context: context,
    builder: (BuildContext context) {
      return const PlaylistCreationForm();
    },
  );
}
