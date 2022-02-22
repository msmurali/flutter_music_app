import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/constants/index.dart';
import '../../logic/bloc/playlists_bloc/bloc.dart';
import '../../logic/bloc/preferences_bloc/bloc.dart';
import '../utils/helpers.dart';
import '../widgets/back_button.dart';
import '../widgets/error_indicator.dart';
import '../widgets/mini_player.dart';
import '../widgets/scaffold_with_sliding_panel.dart';
import '../widgets/tile.dart';
import 'player_screen.dart';

class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({Key? key}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      leading: const BackButton(),
      title: Text(
        'Playlists',
        style: theme.textTheme.headline6,
      ),
    );
  }

  void _navigateToSongsScreen(BuildContext context, dynamic entity) {
    Navigator.pushNamed(context, routes[Routes.songsRoute]!, arguments: entity);
  }

  Widget _buildPlaylists() {
    return BlocBuilder<PlaylistsBloc, PlaylistsState>(builder: (
      BuildContext context,
      PlaylistsState playlistsState,
    ) {
      if (playlistsState.playlists.isEmpty) {
        return const ErrorIndicator(
          asset: 'asset/images/no_playlists.svg',
        );
      } else {
        return BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (BuildContext context, PreferencesState preferencesState) {
            if (preferencesState.view == View.grid) {
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: preferencesState.gridSize,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                ),
                itemCount: playlistsState.playlists.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < playlistsState.playlists.length) {
                    dynamic entity = playlistsState.playlists[index];
                    return Tile(
                      entity: entity,
                      onTap: () {
                        _navigateToSongsScreen(context, entity);
                      },
                      onLongPress: (dynamic details) async {
                        await showMenuDialog(
                            context, details, entity, playlistOptions);
                      },
                    );
                  } else {
                    return const SizedBox(height: 70.0);
                  }
                },
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: playlistsState.playlists.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < playlistsState.playlists.length) {
                    dynamic entity = playlistsState.playlists[index];
                    return Tile(
                      entity: entity,
                      onTap: () {
                        _navigateToSongsScreen(context, entity);
                      },
                      onLongPress: (dynamic details) async {
                        await showMenuDialog(
                            context, details, entity, playlistOptions);
                      },
                    );
                  } else {
                    return const SizedBox(height: 70.0);
                  }
                },
              );
            }
          },
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ScaffoldWithSlidingPanel(
          body: Scaffold(
            appBar: _buildAppBar(context),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildPlaylists(),
            ),
          ),
          collapsed: const MiniPlayer(),
          expanded: const PlayerScreen(),
        ),
      ),
    );
  }
}
