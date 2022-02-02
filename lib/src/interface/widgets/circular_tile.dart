import 'package:flutter/material.dart';
import 'package:music/src/data/providers/artwork_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'circular_artwork.dart';

class CircularTile extends StatelessWidget {
  final SongModel song;
  CircularTile({Key? key, required this.song}) : super(key: key);

  final ArtworkProvider _artworkProvider = ArtworkProvider();

  _buildArtwork() {
    return FutureBuilder(
      future: _artworkProvider.getSongArtwork(song),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(60.0),
              color: Colors.grey,
            ),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          return CircularArtwork(
            radius: 60.0,
            imageData: snapshot.data,
          );
        } else {
          return const CircularArtwork(
            radius: 60.0,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SizedBox(
      width: 135,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildArtwork(),
          SizedBox(
            width: 100,
            child: Text(
              song.title,
              style: theme.textTheme.bodyText2!.copyWith(
                fontSize: 12.0,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Text(
              song.artist ?? 'Unknown',
              style: theme.textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}
