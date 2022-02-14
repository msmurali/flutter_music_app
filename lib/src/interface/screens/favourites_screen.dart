import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../global/constants/enums.dart';
import '../widgets/back_button.dart';
import 'player_screen.dart';
import '../../logic/bloc/preferences_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../logic/bloc/favourites_bloc/bloc.dart';
import '../widgets/error_indicator.dart';
import '../widgets/mini_player.dart';
import '../widgets/scaffold_with_sliding_panel.dart';
import '../widgets/tile.dart';

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
                itemCount: songs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Tile(
                    entity: songs[index],
                  );
                },
              );
            } else {
              return ListView.builder(
                itemCount: songs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Tile(
                    entity: songs[index],
                  );
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
