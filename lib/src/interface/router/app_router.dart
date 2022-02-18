import 'package:flutter/material.dart';

import '../../global/constants/constants.dart';
import '../../global/constants/enums.dart';
import '../screens/favourites_screen.dart';
import '../screens/home_screen.dart';
import '../screens/info_screen.dart';
import '../screens/playlists_screen.dart';
import '../screens/preferences_screen.dart';
import '../screens/search_screen.dart';
import '../screens/songs_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    String? _route = settings.name;

    if (_route == routes[Routes.homeRoute]) {
      return MaterialPageRoute(
        builder: (BuildContext context) => const HomeScreen(),
      );
    } else if (_route == routes[Routes.preferencesRoute]) {
      return MaterialPageRoute(
        builder: (BuildContext context) => const PreferencesScreen(),
      );
    } else if (_route == routes[Routes.songsRoute]) {
      dynamic _entity = settings.arguments;

      return MaterialPageRoute(
        builder: (BuildContext context) => SongsScreen(
          entity: _entity,
        ),
      );
    } else if (_route == routes[Routes.infoRoute]) {
      dynamic _entity = settings.arguments;

      return MaterialPageRoute(
        builder: (BuildContext context) => InfoScreen(
          song: _entity,
        ),
      );
    } else if (_route == routes[Routes.favouritesRoute]) {
      return MaterialPageRoute(
        builder: (BuildContext context) => const FavouritesScreen(),
      );
    } else if (_route == routes[Routes.playlistsRoute]) {
      return MaterialPageRoute(
        builder: (BuildContext context) => const PlaylistsScreen(),
      );
    } else if (_route == routes[Routes.searchRoute]) {
      return MaterialPageRoute(
        builder: (BuildContext context) => const SearchScreen(),
      );
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) => const HomeScreen(),
      );
    }
  }
}
