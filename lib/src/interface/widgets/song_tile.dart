import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/music_artwork.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SongTile extends StatelessWidget {
  final SongModel song;

  const SongTile({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListTile(
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
    );
  }
}
