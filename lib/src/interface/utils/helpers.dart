import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../data/providers/songs_provider.dart';
import '../../data/services/favourites_services.dart';
import '../../data/services/playlist_services.dart';
import '../../global/constants/index.dart';
import '../../logic/bloc/favourites_bloc/bloc.dart';
import '../widgets/playlist_form.dart';

final FavouritesServices _favouritesServices = FavouritesServices();
final PlaylistServices _playlistServices = PlaylistServices();
final SongsProvider _songsProvider = SongsProvider();

Future<void> showMenuDialog(
  BuildContext context,
  dynamic details,
  dynamic entity,
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
      // add to queue
    } else if (value == Option.info) {
      _navigateToInfoScreen(context, entity);
    } else if (value == Option.addToFavourites) {
      _markAsFavourite(entity, context);
    } else if (value == Option.addToPlaylist) {
    } else if (value == Option.addAllToPlaylist) {
    } else if (value == Option.addAllToFavourites) {
      _addAllToFavourites(entity, context);
    } else if (value == Option.removeFromFavourites) {
      _markAsNotFavourite(entity, context);
    } else if (value == Option.removeFromPlaylist) {
    } else if (value == Option.removePlaylist) {}
    return;
  });
}

void _markAsFavourite(dynamic entity, BuildContext context) {
  final SongModel _song = entity as SongModel;
  FavouritesBloc _favBloc = BlocProvider.of<FavouritesBloc>(context);
  _favBloc.add(MarkAsFavourite(song: _song));
}

void _markAsNotFavourite(dynamic entity, BuildContext context) {
  final SongModel _song = entity as SongModel;
  FavouritesBloc _favBloc = BlocProvider.of<FavouritesBloc>(context);
  _favBloc.add(MarkAsNotFavourite(song: _song));
}

void _navigateToInfoScreen(BuildContext context, entity) {
  Navigator.pushNamed(
    context,
    routes[Routes.infoRoute]!,
    arguments: entity,
  );
}

void _addAllToFavourites(dynamic entity, BuildContext context) async {
  late List<SongModel> songs;

  if (entity is AlbumModel) {
    songs = await _songsProvider.getAlbumSongs(entity.album);
  } else if (entity is ArtistModel) {
    songs = await _songsProvider.getArtistSongs(entity.artist);
  }

  await _favouritesServices.addAllToFavourites(
    songs.sublist(0, songs.length - 1),
  );

  _markAsFavourite(songs[songs.length - 1], context);
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
