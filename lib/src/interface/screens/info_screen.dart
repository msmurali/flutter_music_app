import 'package:flutter/material.dart';
import '../widgets/circular_artwork.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../widgets/app_bar_button.dart';
import '../widgets/mini_player.dart';
import '../widgets/scaffold_with_sliding_panel.dart';

class InfoScreen extends StatelessWidget {
  final SongModel song;

  const InfoScreen({Key? key, required this.song}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 56.0,
      leading: const AppBarButton(
        margin: EdgeInsets.only(left: 16.0),
        radius: 20.0,
        tooltip: 'Back',
        child: Padding(
          padding: EdgeInsets.only(
            left: 6.0,
          ),
          child: Icon(
            Icons.arrow_back_ios,
            size: 16.0,
          ),
        ),
      ),
      title: Text(
        song.title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }

  _buildInfoScreen(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircularArtwork(radius: 60.0),
            InfoColumn(
              title: 'Title',
              subtitle: song.title,
            ),
            InfoColumn(
              title: 'Artist',
              subtitle: song.artist ?? 'Unknown Artist',
            ),
            InfoColumn(
              title: 'Album',
              subtitle: song.album ?? 'Unknown Album',
            ),
            InfoColumn(
              title: 'Genre',
              subtitle: song.genre ?? 'Unknown Genre',
            ),
            InfoColumn(
              title: 'Location',
              subtitle: song.data,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ScaffoldWithSlidingPanel(
          body: _buildInfoScreen(context),
          collapsed: const MiniPlayer(),
          expanded: Container(color: Colors.white),
        ),
      ),
    );
  }
}

class InfoColumn extends StatelessWidget {
  const InfoColumn({
    Key? key,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Text(
            title,
            style: theme.textTheme.bodyText2,
          ),
          SizedBox(
            height: 2.0,
            width: 40.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.0),
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: theme.textTheme.bodyText2,
          ),
        ],
      ),
    );
  }
}
