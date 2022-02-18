import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'global/constants/index.dart';
import 'interface/router/app_router.dart';
import 'interface/themes/themes.dart';
import 'logic/bloc/theme_mode_bloc/bloc.dart';

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
