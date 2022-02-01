import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/tile.dart';

class Favourites extends StatelessWidget {
  final _favouritesCount = 5;

  const Favourites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _favouritesCount,
      itemBuilder: (BuildContext context, int index) {
        return const Tile();
      },
    );
  }
}
