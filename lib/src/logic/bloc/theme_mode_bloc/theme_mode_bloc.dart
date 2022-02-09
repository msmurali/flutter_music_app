import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../data/services/preferences_services.dart';
import 'bloc.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvents, ThemeModeState> {
  final PreferencesServices _preferencesServices = PreferencesServices();
  ThemeModeBloc({required ThemeModeState initialState}) : super(initialState) {
    on<SetLightTheme>(_onSetLightTheme);
    on<SetDarkTheme>(_onSetDarkTheme);
    on<SetSystemTheme>(_onSetSystemTheme);
  }

  _onSetLightTheme(SetLightTheme event, Emitter<ThemeModeState> emitter) async {
    ThemeMode _themeMode = ThemeMode.light;

    ThemeModeState _themeModeState = ThemeModeState(themeMode: _themeMode);

    await _preferencesServices.setTheme(_themeMode);

    emitter.call(_themeModeState);
  }

  _onSetDarkTheme(SetDarkTheme event, Emitter<ThemeModeState> emitter) async {
    ThemeMode _themeMode = ThemeMode.dark;

    ThemeModeState _themeModeState = ThemeModeState(themeMode: _themeMode);

    await _preferencesServices.setTheme(_themeMode);

    emitter.call(_themeModeState);
  }

  _onSetSystemTheme(
      SetSystemTheme event, Emitter<ThemeModeState> emitter) async {
    ThemeMode _themeMode = ThemeMode.system;

    ThemeModeState _themeModeState = ThemeModeState(themeMode: _themeMode);

    await _preferencesServices.setTheme(_themeMode);

    emitter.call(_themeModeState);
  }
}
