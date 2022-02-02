import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'error_indicator.dart';
import 'loading_indicator.dart';
import 'tile.dart';

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

  ListView _buildList(BuildContext context, List<dynamic> data) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildTile(context, data[index], index);
      },
    );
  }

  Padding _buildGrid(BuildContext context, List<dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GridView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: data.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return _buildTile(context, data[index], index);
        },
      ),
    );
  }

  _buildTile(BuildContext context, dynamic entity, int index) {
    if (entity is SongModel) {
      return Tile(
        song: entity,
      );
    } else if (entity is AlbumModel) {
      return Tile(
        album: entity,
        onTap: () {
          Navigator.pushNamed(
            context,
            '/songs',
            arguments: entity,
          );
        },
      );
    } else {
      return Tile(
        artist: entity,
        onTap: () {
          Navigator.pushNamed(
            context,
            '/songs',
            arguments: entity,
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingIndicator();
    } else if (snapshot.hasData && snapshot.data != null) {
      List<dynamic> data = snapshot.data;
      return _buildGrid(context, data);
    } else {
      return const ErrorIndicator(
        asset: 'asset/images/no_data_error.svg',
      );
    }
  }
}
