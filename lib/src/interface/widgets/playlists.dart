import 'package:flutter/material.dart';
import 'package:music/src/data/providers/playlists_provider.dart';
import 'package:music/src/interface/widgets/error_indicator.dart';
import 'package:music/src/interface/widgets/loading_indicator.dart';
import '../../global/constants/enums.dart';
import 'tile.dart';

class Playlists extends StatelessWidget {
  final _playlistsCount = 5;
  final PlaylistsProvider _playlistsProvider = PlaylistsProvider();

  Playlists({Key? key}) : super(key: key);

  _buildFavouritesList(BuildContext context, List<dynamic> _playlists) {
    return ListView.builder(
      itemCount: _playlists.length < _playlistsCount
          ? _playlists.length
          : _playlistsCount,
      itemBuilder: (BuildContext context, int index) {
        return Tile(
          entity: _playlists[index],
          view: View.list,
        );
      },
      shrinkWrap: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _playlistsProvider.getPlaylists(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            child: LoadingIndicator(),
            height: 400.0,
          );
        } else if (snapshot.hasData && snapshot.data.isEmpty) {
          return const SizedBox(
            height: 300,
            child: ErrorIndicator(
              asset: 'asset/images/no_playlists.svg',
            ),
          );
        } else {
          List<dynamic> data = snapshot.data;
          return _buildFavouritesList(context, data);
        }
      },
    );
  }
}
