import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../global/constants/constants.dart';
import '../../global/constants/enums.dart';
import '../../logic/bloc/favourites_bloc/bloc.dart';
import '../../logic/bloc/player_bloc/bloc.dart';
import '../../logic/bloc/preferences_bloc/bloc.dart';
import '../utils/helpers.dart';
import '../widgets/back_button.dart';
import '../widgets/error_indicator.dart';
import '../widgets/mini_player.dart';
import '../widgets/scaffold_with_sliding_panel.dart';
import '../widgets/tile.dart';
import 'player_screen.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({
    Key? key,
  }) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      leading: const BackButton(),
      title: Text(
        'Favourites',
        style: theme.textTheme.headline6,
      ),
    );
  }

  Widget _buildFavourites(BuildContext context, List<SongModel> songs) {
    if (songs.isEmpty) {
      return const ErrorIndicator(
        asset: 'asset/images/no_favourites.svg',
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<PreferencesBloc, PreferencesState>(
          builder: (BuildContext context, PreferencesState state) {
            PreferencesState _currentState =
                BlocProvider.of<PreferencesBloc>(context).state;
            if (_currentState.view == View.grid) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _currentState.gridSize,
                  crossAxisSpacing: 6.0,
                  mainAxisSpacing: 6.0,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: songs.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < songs.length) {
                    return Tile(
                      entity: songs[index],
                      onTap: () async {
                        BlocProvider.of<PlayerBloc>(context).add(
                          ChangeQueueList(
                            queue: songs,
                            index: index,
                            context: context,
                          ),
                        );
                      },
                      onLongPress: (dynamic details) async {
                        await showMenuDialog(
                            context, details, songs[index], favSongOptions);
                      },
                    );
                  } else {
                    return const SizedBox(height: 80.0);
                  }
                },
              );
            } else {
              return ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: songs.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < songs.length) {
                    return Tile(
                      entity: songs[index],
                      onTap: () async {
                        BlocProvider.of<PlayerBloc>(context).add(
                          ChangeQueueList(
                            queue: songs,
                            index: index,
                            context: context,
                          ),
                        );
                      },
                      onLongPress: (dynamic details) async {
                        await showMenuDialog(
                            context, details, songs[index], favSongOptions);
                      },
                    );
                  } else {
                    return const SizedBox(height: 90.0);
                  }
                },
              );
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ScaffoldWithSlidingPanel(
          body: Scaffold(
            appBar: _buildAppBar(context),
            body: BlocBuilder<FavouritesBloc, FavouritesState>(
              builder: (context, state) {
                return _buildFavourites(context, state.songs);
              },
            ),
          ),
          collapsed: const MiniPlayer(),
          expanded: const PlayerScreen(),
        ),
      ),
    );
  }
}
