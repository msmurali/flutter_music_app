import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/playlist_form.dart';

import '../utils/helpers.dart';
import 'favourites.dart';
import 'playlists.dart';
import 'recents.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    ThemeData theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
      ),
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Recently Played',
              style: theme.textTheme.bodyText1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
            child: Recents(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Text(
              'Favourites',
              style: theme.textTheme.bodyText1,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 24.0),
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
                  style: theme.textTheme.bodyText1,
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 24.0,
                  ),
                  onPressed: () => showFormDialog(
                    context: context,
                    form: PlaylistCreationForm(),
                  ),
                  splashColor: Colors.white10,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 6.0,
            ),
            child: Playlists(),
          ),
          const SizedBox(height: 70.0),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
