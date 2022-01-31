import 'package:flutter/material.dart';
import 'package:music/src/interface/utils/custom_icons.dart';
import 'package:music/src/interface/widgets/music_artwork.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Tile extends StatelessWidget {
  final SongModel? song;
  final AlbumModel? album;
  final ArtistModel? artist;
  final void Function()? onTap;

  const Tile({
    Key? key,
    this.song,
    this.album,
    this.artist,
    this.onTap,
  }) : super(key: key);

  _getArtwork() {
    if (song != null) {
      return MusicArtwork(
        song: song,
      );
    } else if (album != null) {
      return MusicArtwork(
        album: album,
      );
    } else {
      return MusicArtwork(
        artist: artist,
      );
    }
  }

  String _getTitle() {
    if (song != null) {
      return song!.title;
    } else if (artist != null) {
      return artist!.artist;
    } else {
      return album!.album;
    }
  }

  String _getSubtitle() {
    if (song != null) {
      return song!.artist ?? 'Unknown Artist';
    } else if (artist != null) {
      return '${artist!.numberOfTracks ?? 0}';
    } else {
      return album!.artist ?? 'Unknown Artist';
    }
  }

  ListTile _buildListTile(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListTile(
      leading: _getArtwork(),
      title: Text(
        _getTitle(),
        style: theme.textTheme.bodyText2,
        maxLines: 1,
      ),
      subtitle: Text(
        _getSubtitle(),
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
      onTap: onTap,
    );
  }

  GestureDetector _buildGridTile(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              child: _getArtwork(),
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
                    _getTitle(),
                    style: theme.textTheme.bodyText2,
                  ),
                ),
              ),
            ),
          ],
        ),
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
