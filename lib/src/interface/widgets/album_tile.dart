import 'package:flutter/material.dart';
import 'package:music/src/interface/utils/custom_icons.dart';
import 'package:music/src/interface/widgets/music_artwork.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumTile extends StatelessWidget {
  final AlbumModel album;

  const AlbumTile({Key? key, required this.album}) : super(key: key);

  ListTile _buildListTile(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListTile(
      leading: MusicArtwork(
        album: album,
      ),
      title: Text(
        album.album,
        style: theme.textTheme.bodyText2,
        maxLines: 1,
      ),
      subtitle: Text(
        album.artist ?? 'Unknown Artist',
        style: theme.textTheme.subtitle2,
        maxLines: 1,
      ),
      trailing: IconButton(
        splashRadius: 20.0,
        highlightColor: Colors.pinkAccent.shade100,
        onPressed: () {},
        icon: const Icon(CustomIcons.more),
        iconSize: 18.0,
      ),
    );
  }

  Container _buildGridTile(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1.4,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: MusicArtwork(
              album: album,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  album.album,
                  style: theme.textTheme.bodyText2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: _buildGridTile(context),
    );
  }
}

/* 
list view:
song tile: 
  song title
  song artist
  OPTIONS:
    add to playlist
    add to favourites
    song info
    play next
artist tile:
  artist title
  artist number of songs
  OPTIONS:
album tile:
  album title
  album artist
  OPTIONS:
*/

/* grid view:
song tile: 
  song title
  OPTIONS:
    add to playlist
    add to favourites
    song info
    play next
artist tile:
  artist title
album tile:
  album title
*/
