import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/src/logic/bloc/playlists_bloc/bloc.dart';
import '../../global/constants/index.dart';
import '../utils/helpers.dart';
import 'error_indicator.dart';
import 'tile.dart';

class Playlists extends StatelessWidget {
  final _playlistsCount = 5;

  const Playlists({Key? key}) : super(key: key);

  void _navigateToSongsScreen(BuildContext context, dynamic entity) {
    Navigator.pushNamed(
      context,
      routes[Routes.songsRoute]!,
      arguments: entity,
    );
  }

  Widget _buildPlaylistsList(BuildContext context, List<dynamic> _playlists) {
    return Column(
      children: [
        ListView.builder(
          itemCount: _playlists.length < _playlistsCount
              ? _playlists.length
              : _playlistsCount,
          itemBuilder: (BuildContext context, int index) {
            return Tile(
              entity: _playlists[index],
              view: View.list,
              onTap: () {
                _navigateToSongsScreen(context, _playlists[index]);
              },
              onLongPress: (dynamic details) async {
                await showMenuDialog(
                    context, details, _playlists[index], playlistOptions);
              },
            );
          },
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 10.0,
          ),
          child: TextButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                routes[Routes.playlistsRoute]!,
              );
            },
            child: Text(
              'See More',
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.pinkAccent.shade400,
                  ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlaylistsBloc, PlaylistsState>(
        builder: (BuildContext context, PlaylistsState state) {
      if (state.playlists.isEmpty) {
        return const SizedBox(
          height: 300,
          child: ErrorIndicator(
            asset: 'asset/images/no_playlists.svg',
          ),
        );
      } else {
        return _buildPlaylistsList(context, state.playlists);
      }
    });
  }
}
