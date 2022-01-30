import 'package:flutter/material.dart';
import 'package:music/src/interface/utils/custom_icons.dart';
import 'package:music/src/interface/widgets/music_artwork.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatelessWidget {
  final SongModel song;

  const SongTile({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ListTile(
        leading: MusicArtwork(
          song: song,
        ),
        title: Text(
          song.title,
          style: theme.textTheme.bodyText2,
          maxLines: 1,
        ),
        subtitle: Text(
          song.artist ?? 'Unknown Artist',
          style: theme.textTheme.subtitle2,
          maxLines: 1,
        ),
        trailing: IconButton(
          splashRadius: 20.0,
          highlightColor: Colors.pink.shade100,
          onPressed: () {},
          icon: const Icon(CustomIcons.more),
          iconSize: 18.0,
        ),
      ),
    );
  }
}
