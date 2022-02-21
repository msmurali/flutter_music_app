import 'dart:async';

import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../data/models/playlist.dart';
import '../../data/providers/playlists_provider.dart';
import '../../data/providers/songs_provider.dart';
import '../../global/constants/constants.dart';
import '../../global/constants/enums.dart';
import '../../logic/bloc/player_bloc/bloc.dart';
import '../../logic/bloc/preferences_bloc/bloc.dart';
import '../../logic/bloc/theme_mode_bloc/bloc.dart';
import '../utils/helpers.dart';
import '../widgets/back_button.dart';
import '../widgets/error_indicator.dart';
import '../widgets/loading_indicator.dart';
import '../widgets/mini_player.dart';
import '../widgets/music_artwork.dart';
import '../widgets/scaffold_with_sliding_panel.dart';
import '../widgets/tile.dart';
import 'player_screen.dart';

class SongsScreen extends StatelessWidget {
  final dynamic entity;

  const SongsScreen({Key? key, required this.entity}) : super(key: key);

  Widget _buildSongs() {
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
      Playlist _playlist = entity as Playlist;
      _future = _playlistsProvider.getPlaylistSongs(_playlist.name);
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

  List<Option> _getOptions() {
    if (entity is Playlist) {
      return playlistSongOptions;
    } else {
      return songOptions;
    }
  }

  SliverList _buildList(List<dynamic> data) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          if (index < data.length) {
            return Tile(
              entity: data[index],
              onTap: () async {
                BlocProvider.of<PlayerBloc>(context).add(
                  ChangeQueueList(
                    queue: data as List<SongModel>,
                    index: index,
                    context: context,
                  ),
                );
              },
              onLongPress: (dynamic details) async {
                List<Option> options = _getOptions();
                await showMenuDialog(
                    context,
                    details,
                    entity is Playlist
                        ? {
                            'playlistName': entity.name,
                            'song': data[index],
                          }
                        : data[index],
                    options);
              },
            );
          } else {
            return const SizedBox(height: 90.0);
          }
        },
        childCount: data.length + 1,
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
          if (index < data.length) {
            return Tile(
              entity: data[index],
              onTap: () async {
                BlocProvider.of<PlayerBloc>(context).add(
                  ChangeQueueList(
                    queue: data as List<SongModel>,
                    index: index,
                    context: context,
                  ),
                );
              },
              onLongPress: (dynamic details) async {
                List<Option> options = _getOptions();

                await showMenuDialog(
                    context,
                    details,
                    entity is Playlist
                        ? {
                            'playlistName': entity.name,
                            'song': data[index],
                          }
                        : data[index],
                    options);
              },
            );
          } else {
            return const SizedBox(height: 90.0);
          }
        },
        childCount: data.length + 1,
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
      _title = entity.name;
    }

    return Text(
      _title,
      style: Theme.of(context).textTheme.headline6!.copyWith(
            color: Colors.grey[400],
          ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
    );
  }

  Widget _getArtwork() {
    return MusicArtwork(
      borderRadius: 0.0,
      entity: entity,
    );
  }

  Widget _buildAppBarBackground(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: _getArtwork(),
        ),
        Positioned.fill(
          child: BlocBuilder<ThemeModeBloc, ThemeModeState>(
            builder: (context, state) {
              if (state.themeMode == ThemeMode.dark) {
                return Container(
                    decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Theme.of(context).colorScheme.primary.withOpacity(0.05),
                    ],
                    stops: const [
                      0.00,
                      1.00,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ));
              } else {
                return const SizedBox();
              }
            },
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
            titleTextStyle: Theme.of(context).textTheme.headline6,
            centerTitle: true,
            stretch: true,
            pinned: true,
            leadingWidth: 56.0,
            leading: BackButton(
              color: Colors.white,
              backgroundColor: Colors.black.withOpacity(0.05),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: _getTitle(context),
              centerTitle: true,
              titlePadding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
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
