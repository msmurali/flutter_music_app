import 'package:flutter/material.dart';
import 'package:music/src/data/providers/favourites_provider.dart';

import '../widgets/app_bar_button.dart';
import '../widgets/error_indicator.dart';
import '../widgets/mini_player.dart';
import '../widgets/music_tab.dart';
import '../widgets/scaffold_with_sliding_panel.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({
    Key? key,
  }) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      leading: AppBarButton(
        margin: const EdgeInsets.only(left: 16.0),
        radius: 20.0,
        tooltip: 'Back',
        child: const Padding(
          padding: EdgeInsets.only(
            left: 6.0,
          ),
          child: Icon(
            Icons.arrow_back_ios,
            size: 16.0,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Favourites',
        style: theme.textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FavouritesProvider _favouritesProvider = FavouritesProvider();

    return Material(
      child: SafeArea(
        child: ScaffoldWithSlidingPanel(
          body: Scaffold(
            appBar: _buildAppBar(context),
            body: MusicTab(
              futureData: _favouritesProvider.getFavouritesSongs(),
              errorIndicator: const ErrorIndicator(
                asset: 'asset/images/no_favourites.svg',
              ),
            ),
          ),
          collapsed: const MiniPlayer(),
          expanded: Container(color: Colors.white),
        ),
      ),
    );
  }
}
