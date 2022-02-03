import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/src/data/services/app_shared_preferences.dart';
import 'package:music/src/data/services/preferences_services.dart';
import 'package:music/src/logic/bloc/preferences_bloc/bloc.dart';
import 'data/services/favourites_services.dart';
import 'data/services/queue_services.dart';
import 'data/services/recents_services.dart';
import 'logic/bloc/theme_mode_bloc/bloc.dart';
import 'data/services/app_permissions.dart';
import 'global/constants/index.dart';
import './interface/themes/themes.dart';
import 'interface/router/app_router.dart';

class AppWidgetWrapper extends StatefulWidget {
  const AppWidgetWrapper({Key? key}) : super(key: key);

  @override
  State<AppWidgetWrapper> createState() => _AppWidgetWrapperState();
}

class _AppWidgetWrapperState extends State<AppWidgetWrapper> {
  final AppSharedPreferences _sharedPreferences = AppSharedPreferences();
  final FavouritesServices _favouritesServices = FavouritesServices();
  final RecentsServices _recentsServices = RecentsServices();
  final QueueServices _queueServices = QueueServices();
  final PreferencesServices _preferencesServices = PreferencesServices();

  @override
  void initState() {
    super.initState();
    _getStorageAccessPermission();
    _initiateStorageRooms();
  }

  Future<void> _getStorageAccessPermission() async {
    await AppPermissions.requestPermissions();
  }

  Future<void> _initiateStorageRooms() async {
    await _sharedPreferences.init();

    if (!await _favouritesServices.favouritesAlreadyExists()) {
      _favouritesServices.createFavourites();
    }
    if (!_queueServices.queueAlreadyExists()) {
      _queueServices.createQueue();
    }
    if (!_recentsServices.recentsAlreadyExists()) {
      _recentsServices.createRecents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeModeBloc(
            initialState: ThemeModeState(
              themeMode: ThemeMode.dark, // TODO:
            ),
          ),
        ),
        BlocProvider(
          create: (context) => PreferencesBloc(
            initialState: PreferencesState(
              view: _preferencesServices.getView(),
              gridSize: _preferencesServices.getGridSize(),
              sortType: _preferencesServices.getSongSortType(),
              orderType: _preferencesServices.getOrderType(),
            ),
          ),
        ),
      ],
      child: const AppWidget(),
    );
  }
}

class AppWidget extends StatelessWidget {
  const AppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeModeBloc, ThemeModeState>(
      buildWhen: (ThemeModeState previous, ThemeModeState current) =>
          previous.themeMode != current.themeMode,
      builder: (context, state) {
        return MaterialApp(
          title: 'Music',
          themeMode: BlocProvider.of<ThemeModeBloc>(context).state.themeMode,
          theme: lightThemeData,
          darkTheme: darkThemeData,
          onGenerateRoute: AppRouter.generateRoute,
          initialRoute: routes[Routes.homeRoute],
        );
      },
    );
  }
}
