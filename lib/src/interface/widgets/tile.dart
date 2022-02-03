import 'package:flutter/material.dart' hide GridTile;
import 'grid_tile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/src/global/constants/enums.dart';
import 'package:music/src/logic/bloc/preferences_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'custom_list_tile.dart';
import 'music_artwork.dart';

class Tile extends StatelessWidget {
  // final SongModel? song;
  // final AlbumModel? album;
  // final ArtistModel? artist;
  // final PlaylistModel? playlist;
  final dynamic entity;
  final void Function()? onTap;

  const Tile({
    Key? key,
    // this.song,
    // this.album,
    // this.artist,
    // this.playlist,
    this.entity,
    this.onTap,
  }) : super(key: key);

  Widget _getArtwork() {
    // if (song != null) {
    //   return MusicArtwork(
    //     song: song,
    //   );
    // } else if (album != null) {
    //   return MusicArtwork(
    //     album: album,
    //   );
    // } else if (artist != null) {
    //   return MusicArtwork(
    //     artist: artist,
    //   );
    // } else {
    //   return MusicArtwork(
    //     playlist: playlist,
    //   );
    // }
    return MusicArtwork(entity: entity);
  }

  String _getTitle() {
    // if (song != null) {
    //   return song!.title;
    // } else if (artist != null) {
    //   return artist!.artist;
    // } else if (album != null) {
    //   return album!.album;
    // } else {
    //   return playlist!.playlist;
    // }
    if (entity is SongModel) {
      return entity!.title;
    } else if (entity is ArtistModel) {
      return entity!.artist;
    } else if (entity is AlbumModel) {
      return entity!.album;
    } else {
      return entity!.playlist;
    }
  }

  String _getSubtitle() {
    // if (song != null) {
    //   return song!.artist ?? 'Unknown Artist';
    // } else if (artist != null) {
    //   return '${artist!.numberOfTracks ?? 0}';
    // } else if (album != null) {
    //   return album!.artist ?? 'Unknown Artist';
    // } else {
    //   return '${playlist!.numOfSongs} songs';
    // }
    if (entity is SongModel) {
      return entity!.artist ?? 'Unknown Artist';
    } else if (entity is ArtistModel) {
      return '${entity!.numberOfTracks ?? 0}';
    } else if (entity is AlbumModel) {
      return entity.artist ?? 'Unknown Artist';
    } else {
      return '${entity.numOfSongs} songs';
    }
  }

  @override
  Widget build(BuildContext context) {
    PreferencesState _currentState =
        BlocProvider.of<PreferencesBloc>(context).state;
    if (_currentState.view == View.list) {
      return CustomListTile(
        title: _getTitle(),
        subtitle: _getSubtitle(),
        artwork: _getArtwork(),
        onTap: onTap,
        onTrailingPressed: () {},
      );
    } else {
      return GridTile(
        artwork: _getArtwork(),
        onLongPress: () {},
        title: _getTitle(),
        onTap: onTap,
        gridSize: _currentState.gridSize,
      );
    }
  }
}
