import 'package:flutter/material.dart';
import 'package:music/src/logic/bloc/theme_mode_bloc/bloc.dart';
import '../../global/constants/constants.dart';
import '../../global/constants/enums.dart';
import '../screens/home_screen.dart';
import '../screens/preferences_screen.dart';
import '../screens/songs_screen.dart';

class AppRouter {
  // final ThemeModeBloc _themeModeBloc =
  //     ThemeModeBloc(initialState: ThemeModeState(themeMode: ThemeMode.dark));

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
