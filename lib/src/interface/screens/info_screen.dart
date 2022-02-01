import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/app_bar_button.dart';
import 'package:music/src/interface/widgets/circular_artwork.dart';
import 'package:music/src/interface/widgets/scaffold_with_sliding_panel.dart';
import 'package:music/src/interface/widgets/mini_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
          children: [],
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
