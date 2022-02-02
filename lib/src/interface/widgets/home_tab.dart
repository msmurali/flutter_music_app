import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/recents.dart';
import 'playlists.dart';
import 'favourites.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
      ),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Recently Played',
            style: theme.textTheme.bodyText2,
          ),
          const Recents(),
          Text(
            'Favourites',
            style: theme.textTheme.bodyText2,
          ),
          Favourites(),
          Text(
            'Playlists',
            style: theme.textTheme.bodyText2,
          ),
          Playlists(),
        ],
      ),
    );
  }
}
