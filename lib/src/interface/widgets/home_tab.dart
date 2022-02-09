import 'package:flutter/material.dart';

import '../utils/helpers.dart';
import 'favourites.dart';
import 'playlists.dart';
import 'recents.dart';

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
            padding: const EdgeInsets.only(
              left: 24.0,
              right: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Playlists',
                  style: theme.textTheme.bodyText2,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 20.0,
                  ),
                  onPressed: () => showFormDialog(context),
                  splashColor: Colors.white10,
                ),
              ],
            ),
          ),
          Playlists(),
        ],
      ),
    );
  }
}
