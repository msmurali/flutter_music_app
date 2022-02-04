import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music/src/data/providers/songs_provider.dart';
import 'package:music/src/data/services/favourites_services.dart';
import 'package:music/src/data/services/playlist_services.dart';
import 'package:music/src/global/constants/index.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
    if (value == Option.select) {
    } else if (value == Option.playNext) {
    } else if (value == Option.info) {
      _navigateToInfoScreen(context, entity);
    } else if (value == Option.addToFavourites) {
      await _addToFavourites(entity);
    } else if (value == Option.addToPlaylist) {
    } else if (value == Option.addAllToPlaylist) {
    } else if (value == Option.addAllToFavourites) {
      await _addAllToFavourites(entity);
    } else if (value == Option.removeFromFavourites) {
    } else {
      return;
    }
  });
}

void _navigateToInfoScreen(BuildContext context, entity) {
  Navigator.pushNamed(
    context,
    routes[Routes.infoRoute]!,
    arguments: entity,
  );
}

Future<bool> _addToFavourites(entity) async {
  return await _favouritesServices.addToFavourites(entity.id);
}

Future<bool> _addAllToFavourites(entity) async {
  late List<SongModel> songs;
  if (entity is AlbumModel) {
    songs = await _songsProvider.getAlbumSongs(entity.album);
  } else if (entity is ArtistModel) {
    songs = await _songsProvider.getArtistSongs(entity.artist);
  }
  return await _favouritesServices.addAllToFavourites(songs);
}
