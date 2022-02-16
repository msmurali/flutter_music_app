import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../global/constants/index.dart';
import '../../logic/bloc/favourites_bloc/bloc.dart';
import '../utils/helpers.dart';
import 'error_indicator.dart';
import 'tile.dart';

class Favourites extends StatelessWidget {
  final _favouritesCount = 5;

  const Favourites({Key? key}) : super(key: key);

  _buildFavouritesList(BuildContext context, List<dynamic> _songs) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          ListView.builder(
            itemCount: _songs.length < _favouritesCount
                ? _songs.length
                : _favouritesCount,
            itemBuilder: (BuildContext context, int index) {
              return Tile(
                entity: _songs[index],
                onTap: () {},
                view: View.list,
                onLongPress: (dynamic details) async {
                  await showMenuDialog(
                      context, details, _songs[index], favSongOptions);
                },
              );
            },
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
            ),
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, routes[Routes.favouritesRoute]!);
              },
              child: Text(
                'See More',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.pinkAccent.shade400,
                  fontWeight: FontWeight.w400,
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
    return BlocBuilder<FavouritesBloc, FavouritesState>(
      builder: (context, state) {
        if (state.songs.isEmpty) {
          return const SizedBox(
            height: 300,
            child: ErrorIndicator(
              asset: 'asset/images/no_favourites.svg',
            ),
          );
        } else {
          List<dynamic> songs = state.songs;
          return _buildFavouritesList(context, songs);
        }
      },
    );
  }
}
