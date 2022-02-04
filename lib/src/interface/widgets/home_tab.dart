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
        vertical: 20.0,
      ),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Recently Played',
              style: theme.textTheme.bodyText2,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Recents(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Favourites',
              style: theme.textTheme.bodyText2,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Favourites(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Playlists',
              style: theme.textTheme.bodyText2,
            ),
          ),
          Playlists(),
        ],
      ),
    );
  }
}
