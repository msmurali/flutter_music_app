import 'package:flutter/material.dart';
import 'package:music/src/global/constants/constants.dart';
import 'package:music/src/global/constants/enums.dart';
import 'package:music/src/interface/screens/home_screen.dart';
import 'package:music/src/interface/screens/preferences_screen.dart';
import 'package:music/src/interface/screens/songs_screen.dart';

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
    } else {
      return MaterialPageRoute(
        builder: (BuildContext context) => const HomeScreen(),
      );
    }
  }
}
