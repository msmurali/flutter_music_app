import 'package:flutter/material.dart' hide BackButton;
import 'package:on_audio_query/on_audio_query.dart';

import '../../data/providers/artwork_provider.dart';
import '../widgets/back_button.dart';
import '../widgets/circular_artwork.dart';
import '../widgets/mini_player.dart';
import '../widgets/scaffold_with_sliding_panel.dart';
import 'player_screen.dart';

final ArtworkProvider _artworkProvider = ArtworkProvider();

class InfoScreen extends StatelessWidget {
  final SongModel song;

  const InfoScreen({Key? key, required this.song}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 56.0,
      leading: const BackButton(),
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
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: _artworkProvider.getSongArtwork(song),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                      width: 260,
                      height: 260,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(130.0),
                        color: Colors.grey,
                      ),
                    );
                  } else if (snapshot.hasData && snapshot.data != null) {
                    return CircularArtwork(
                      radius: 130.0,
                      imageData: snapshot.data,
                    );
                  } else {
                    return const CircularArtwork(
                      radius: 130.0,
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),
              InfoColumn(
                title: 'Title',
                subtitle: song.title,
              ),
              const SizedBox(height: 20.0),
              InfoColumn(
                title: 'Artist',
                subtitle: song.artist ?? 'Unknown Artist',
              ),
              const SizedBox(height: 20.0),
              InfoColumn(
                title: 'Album',
                subtitle: song.album ?? 'Unknown Album',
              ),
              const SizedBox(height: 20.0),
              InfoColumn(
                title: 'Genre',
                subtitle: song.genre ?? 'Unknown Genre',
              ),
              const SizedBox(height: 20.0),
              InfoColumn(
                title: 'Location',
                subtitle: song.data,
              ),
              const SizedBox(height: 20.0),
            ],
          ),
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
          expanded: const PlayerScreen(),
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
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.bodyText2!.copyWith(fontSize: 17.0),
          ),
          SizedBox(
            height: 2.0,
            width: 25.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1.0),
                color: Colors.pinkAccent.shade400,
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          Text(
            subtitle,
            style: theme.textTheme.bodyText2,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
