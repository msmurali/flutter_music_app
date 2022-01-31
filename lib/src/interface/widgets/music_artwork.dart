import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:music/src/data/providers/artwork_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicArtwork extends StatelessWidget {
  final SongModel? song;
  final ArtistModel? artist;
  final AlbumModel? album;
  final PlaylistModel? playlist;
  final double? borderRadius;

  const MusicArtwork({
    Key? key,
    this.song,
    this.artist,
    this.album,
    this.playlist,
    this.borderRadius,
  }) : super(key: key);

  Container _buildArtworkLoadingIndicator() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      ),
    );
  }

  Container _buildArtwork(byteData) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(byteData),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      ),
    );
  }

  Container _buildArtworkPlaceholder() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage('asset/images/placeholder.jpg'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      ),
    );
  }

  Future<Uint8List?> getArtworkData() async {
    final ArtworkProvider _artworkProvider = ArtworkProvider();
    if (song != null) {
      return await _artworkProvider.getSongArtwork(song!);
    } else if (artist != null) {
      return await _artworkProvider.getArtistArtwork(artist!);
    } else if (album != null) {
      return await _artworkProvider.getAlbumArtwork(album!);
    } else {
      return await _artworkProvider.getPlaylistArtwork(playlist!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getArtworkData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildArtworkLoadingIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          return _buildArtwork(snapshot.data);
        } else {
          return _buildArtworkPlaceholder();
        }
      },
    );
  }
}
