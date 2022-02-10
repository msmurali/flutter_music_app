import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../global/constants/enums.dart';
import 'player_screen.dart';
import '../../logic/bloc/preferences_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../data/providers/playlists_provider.dart';
import '../../data/providers/songs_provider.dart';
import '../widgets/back_button.dart';
import '../widgets/error_indicator.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/mini_player.dart';
import '../widgets/music_artwork.dart';
import '../widgets/scaffold_with_sliding_panel.dart';
import '../widgets/tile.dart';

class SongsScreen extends StatelessWidget {
  final dynamic entity;

  const SongsScreen({Key? key, required this.entity}) : super(key: key);

  FutureBuilder _buildSongs() {
    late Future<List<dynamic>> _future;

    SongsProvider _songsProvider = SongsProvider();
    PlaylistsProvider _playlistsProvider = PlaylistsProvider();

    if (entity is AlbumModel) {
      AlbumModel _album = entity as AlbumModel;
      _future = _songsProvider.getAlbumSongs(_album.album);
    } else if (entity is ArtistModel) {
      ArtistModel _artist = entity as ArtistModel;
      _future = _songsProvider.getArtistSongs(_artist.artist);
    } else {
      PlaylistModel _playlist = entity as PlaylistModel;
      _future = _playlistsProvider.getPlaylistSongs(_playlist.id);
    }

    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SliverFillRemaining(
            child: LoadingIndicator(),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return SliverPadding(
            sliver: BlocBuilder<PreferencesBloc, PreferencesState>(
                builder: (BuildContext context, PreferencesState state) {
              if (state.view == View.list) {
                return _buildList(snapshot.data);
              } else {
                return _buildGrid(snapshot.data);
              }
            }),
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 8.0,
            ),
          );
        } else {
          return const SliverFillRemaining(
            child: ErrorIndicator(
              asset: 'asset/images/no_data_error.svg',
            ),
          );
        }
      },
    );
  }

  SliverList _buildList(List<dynamic> data) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Tile(
            entity: data[index],
          );
        },
        childCount: data.length,
      ),
    );
  }

  SliverGrid _buildGrid(List<dynamic> data) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Tile(
            entity: data[index],
          );
        },
        childCount: data.length,
      ),
    );
  }

  Text _getTitle(BuildContext context) {
    late String _title;
    if (entity is AlbumModel) {
      _title = entity.album;
    } else if (entity is ArtistModel) {
      _title = entity.artist;
    } else {
      _title = entity.playlist;
    }

    return Text(
      _title,
      style: const TextStyle(
        fontSize: 12.0,
        fontFamily: 'Poppins',
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  _getArtwork() {
    return MusicArtwork(
      borderRadius: 0.0,
      entity: entity,
    );
  }

  _buildAppBarBackground(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _getArtwork(),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Theme.of(context).colorScheme.primary,
                ],
                stops: const [
                  0.80,
                  1.00,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Scaffold _buildSongsScreen(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            stretch: true,
            pinned: true,
            leadingWidth: 56.0,
            leading: const BackButton(),
            flexibleSpace: FlexibleSpaceBar(
              title: _getTitle(context),
              centerTitle: true,
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 8.0,
              ),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
              ],
              background: _buildAppBarBackground(context),
            ),
            expandedHeight: 280.0,
          ),
          _buildSongs()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ScaffoldWithSlidingPanel(
          body: _buildSongsScreen(context),
          collapsed: const MiniPlayer(),
          expanded: const PlayerScreen(),
        ),
      ),
    );
  }
}
