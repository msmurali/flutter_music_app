import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../interface/widgets/preferences_option.dart';
import '../../logic/bloc/theme_mode_bloc/bloc.dart';

class ThemePreferences extends StatelessWidget {
  const ThemePreferences({Key? key}) : super(key: key);

  Row _themeModeBlocBuilder(BuildContext context, ThemeModeState themeState) {
    ThemeMode currentThemeMode =
        BlocProvider.of<ThemeModeBloc>(context).state.themeMode;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PreferencesOption(
          active: currentThemeMode == ThemeMode.light,
          asset: 'asset/images/light_theme.svg',
          title: 'Light',
          onTap: () {
            BlocProvider.of<ThemeModeBloc>(context).add(SetLightTheme());
          },
        ),
        PreferencesOption(
          active: currentThemeMode == ThemeMode.dark,
          asset: 'asset/images/dark_theme.svg',
          title: 'Dark',
          onTap: () {
            BlocProvider.of<ThemeModeBloc>(context).add(SetDarkTheme());
          },
        ),
        PreferencesOption(
          active: currentThemeMode == ThemeMode.system,
          asset: 'asset/images/system_theme.svg',
          title: 'System',
          onTap: () {
            BlocProvider.of<ThemeModeBloc>(context).add(SetSystemTheme());
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme',
          style: theme.textTheme.bodyText2,
        ),
        const SizedBox(height: 20.0),
        BlocBuilder(
          buildWhen: (ThemeModeState previous, ThemeModeState current) =>
              previous.themeMode != current.themeMode,
          bloc: BlocProvider.of<ThemeModeBloc>(context),
          builder: _themeModeBlocBuilder,
        ),
      ],
    );
  }
}
