import 'package:flutter/material.dart';
import 'package:music/src/data/providers/favourites_provider.dart';
import 'package:music/src/interface/widgets/error_indicator.dart';
import 'package:music/src/interface/widgets/loading_indicator.dart';
import 'tile.dart';

class Favourites extends StatelessWidget {
  final _favouritesCount = 5;
  final FavouritesProvider _favouritesProvider = FavouritesProvider();

  Favourites({Key? key}) : super(key: key);

  Expanded _buildFavouritesList(BuildContext context, List<dynamic> _songs) {
    return Expanded(
      child: ListView.builder(
        itemCount: _favouritesCount,
        itemBuilder: (BuildContext context, int index) {
          return Tile(
            onTap: () {},
            entity: _songs[index],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _favouritesProvider.getFavouritesSongs(),
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
              asset: 'asset/images/no_favourites.svg',
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
