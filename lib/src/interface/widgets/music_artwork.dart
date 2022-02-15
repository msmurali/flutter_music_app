import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:music/src/data/models/playlist.dart';
import 'package:music/src/interface/widgets/placeholder_image.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../data/providers/artwork_provider.dart';

class MusicArtwork extends StatelessWidget {
  final dynamic entity;
  final double? borderRadius;
  final double _width = 60;
  final double _height = 60;

  const MusicArtwork({
    Key? key,
    required this.entity,
    this.borderRadius,
  }) : super(key: key);

  Container _buildArtworkLoadingIndicator() {
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      ),
    );
  }

  ClipRRect _buildArtwork(byteData) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
      child: Container(
        width: _width,
        height: _height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        child: SizedBox.expand(
            child: Image.memory(
          byteData,
          fit: BoxFit.cover,
          errorBuilder: (
            BuildContext context,
            Object exception,
            StackTrace? stackTrace,
          ) =>
              const PlaceholderImage(),
        )),
      ),
    );
  }

  Container _buildArtworkPlaceholder() {
    return Container(
      width: _width,
      height: _height,
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

    if (entity is SongModel) {
      return await _artworkProvider.getSongArtwork(
        entity as SongModel,
      );
    } else if (entity is ArtistModel) {
      return await _artworkProvider.getArtistArtwork(
        entity as ArtistModel,
      );
    } else if (entity is AlbumModel) {
      return await _artworkProvider.getAlbumArtwork(
        entity as AlbumModel,
      );
    } else {
      Playlist _playlist = entity as Playlist;
      return await _artworkProvider.getPlaylistArtwork(
        _playlist.name,
      );
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
