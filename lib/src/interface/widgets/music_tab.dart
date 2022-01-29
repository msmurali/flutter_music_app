import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/album_tile.dart';
import 'package:music/src/interface/widgets/artist_tile.dart';
import 'package:music/src/interface/widgets/error_indicator.dart';
import 'package:music/src/interface/widgets/loading_indicator.dart';
import 'package:music/src/interface/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicTab extends StatelessWidget {
  final Future<List<dynamic>> futureData;

  const MusicTab({Key? key, required this.futureData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MusicList(
          snapshot: snapshot,
        );
      },
    );
  }
}

class MusicList extends StatelessWidget {
  final AsyncSnapshot snapshot;

  const MusicList({Key? key, required this.snapshot}) : super(key: key);

  ListView _buildList(List<dynamic> data) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildTile(data[index]);
      },
    );
  }

  _buildTile(entity) {
    if (entity is SongModel) {
      return SongTile(
        song: entity,
      );
    } else if (entity is AlbumModel) {
      return const AlbumTile();
    } else {
      return const ArtistTile();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingIndicator();
    } else if (snapshot.hasData && snapshot.data != null) {
      List<dynamic> data = snapshot.data;
      return _buildList(data);
    } else {
      return const ErrorIndicator();
    }
  }
}
