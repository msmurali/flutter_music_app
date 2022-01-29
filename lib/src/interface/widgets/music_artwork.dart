import 'package:flutter/material.dart';
import 'package:music/src/logic/providers/artwork_provider.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicArtwork extends StatelessWidget {
  final SongModel song;
  final ArtworkProvider _artworkProvider = ArtworkProvider();

  MusicArtwork({Key? key, required this.song}) : super(key: key);

  Container _buildArtworkLoadingIndicator() {
    // TODO: replace
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
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
        ),
        borderRadius: BorderRadius.circular(8.0),
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
        borderRadius: BorderRadius.circular(8.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _artworkProvider.getArtworkData(song),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildArtworkLoadingIndicator();
        } else if (snapshot.hasData && snapshot.data != null) {
          return _buildArtwork(snapshot.data);
        } else {
          // print(snapshot.data);
          return _buildArtworkPlaceholder();
        }
      },
    );
  }
}
