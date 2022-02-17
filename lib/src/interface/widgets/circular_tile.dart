import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../data/providers/artwork_provider.dart';
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
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildArtwork(),
          const SizedBox(height: 4.0),
          SizedBox(
            width: 100,
            child: Text(
              song.title,
              style: theme.textTheme.subtitle1!.copyWith(
                fontSize: 11.0,
              ),
              overflow: TextOverflow.fade,
              maxLines: 1,
              softWrap: false,
            ),
          ),
          SizedBox(
            width: 60,
            child: Text(
              song.artist ?? 'Unknown',
              style: theme.textTheme.subtitle2!.copyWith(
                color: Colors.grey,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ],
      ),
    );
  }
}
