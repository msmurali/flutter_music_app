import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/album_tile.dart';
import 'package:music/src/interface/widgets/artist_tile.dart';
import 'package:music/src/interface/widgets/error_indicator.dart';
import 'package:music/src/interface/widgets/loading_indicator.dart';
import 'package:music/src/interface/widgets/song_tile.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MusicTab extends StatefulWidget {
  final Future<List<dynamic>> futureData;

  const MusicTab({Key? key, required this.futureData}) : super(key: key);

  @override
  State<MusicTab> createState() => _MusicTabState();
}

class _MusicTabState extends State<MusicTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: widget.futureData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MusicList(
          snapshot: snapshot,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
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
