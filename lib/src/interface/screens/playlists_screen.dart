import 'package:flutter/material.dart' hide BackButton;
import '../../data/models/playlist.dart';
import '../widgets/back_button.dart';
import 'player_screen.dart';

import '../../data/providers/playlists_provider.dart';
import '../widgets/error_indicator.dart';
import '../widgets/mini_player.dart';
import '../widgets/music_tab.dart';
import '../widgets/scaffold_with_sliding_panel.dart';

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

  Widget _buildPlaylists() {
    final PlaylistsProvider _playlistsProvider = PlaylistsProvider();
    return MusicTab(
      futureData: _playlistsProvider.getPlaylists() as Future<List<Playlist>>,
      errorIndicator: const ErrorIndicator(
        asset: 'asset/images/no_playlists.svg',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ScaffoldWithSlidingPanel(
          body: Scaffold(
            appBar: _buildAppBar(context),
            body: _buildPlaylists(),
          ),
          collapsed: const MiniPlayer(),
          expanded: const PlayerScreen(),
        ),
      ),
    );
  }
}
