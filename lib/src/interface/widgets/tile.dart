import 'package:flutter/material.dart' hide GridTile;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/enums.dart';
import '../../logic/bloc/preferences_bloc/bloc.dart';
import 'custom_list_tile.dart';
import 'grid_tile.dart';
import 'music_artwork.dart';

class Tile extends StatelessWidget {
  final dynamic entity;
  final void Function()? onTap;
  final void Function(dynamic)? onLongPress;
  final View? view;

  const Tile({
    Key? key,
    required this.entity,
    this.onTap,
    this.onLongPress,
    this.view,
  }) : super(key: key);

  Widget _getArtwork() {
    return MusicArtwork(entity: entity);
  }

  String _getTitle() {
    if (entity is SongModel) {
      return entity!.title;
    } else if (entity is ArtistModel) {
      return entity!.artist;
    } else if (entity is AlbumModel) {
      return entity!.album;
    } else {
      return entity!.name;
    }
  }

  String _getSubtitle() {
    if (entity is SongModel) {
      return entity!.artist ?? 'Unknown Artist';
    } else if (entity is ArtistModel) {
      return '${entity!.numberOfTracks ?? 0} Songs';
    } else if (entity is AlbumModel) {
      return entity.artist ?? 'Unknown Artist';
    } else {
      return '${entity!.numOfSongs} songs';
    }
  }

  @override
  Widget build(BuildContext context) {
    PreferencesState _currentState =
        BlocProvider.of<PreferencesBloc>(context).state;

    if (view == View.list || _currentState.view == View.list) {
      return CustomListTile(
        title: _getTitle(),
        subtitle: _getSubtitle(),
        artwork: _getArtwork(),
        onTap: onTap,
        onTrailingPressed: onLongPress,
        entity: entity,
      );
    } else {
      return GridTile(
        artwork: _getArtwork(),
        onLongPress: onLongPress,
        title: _getTitle(),
        onTap: onTap,
        gridSize: _currentState.gridSize,
        entity: entity,
      );
    }
  }
}
