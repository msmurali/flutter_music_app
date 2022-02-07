import 'package:flutter/material.dart';

import '../../data/providers/playlists_provider.dart';
import '../widgets/app_bar_button.dart';
import '../widgets/error_indicator.dart';
import '../widgets/mini_player.dart';
import '../widgets/music_tab.dart';
import '../widgets/scaffold_with_sliding_panel.dart';

class PlaylistsScreen extends StatelessWidget {
  const PlaylistsScreen({Key? key}) : super(key: key);

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
        'Playlists',
        style: theme.textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PlaylistsProvider _playlistsProvider = PlaylistsProvider();
    return Material(
      child: SafeArea(
        child: ScaffoldWithSlidingPanel(
          body: Scaffold(
            appBar: _buildAppBar(context),
            body: MusicTab(
              futureData: _playlistsProvider.getPlaylists(),
              errorIndicator: const ErrorIndicator(
                asset: 'asset/images/no_playlists.svg',
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
