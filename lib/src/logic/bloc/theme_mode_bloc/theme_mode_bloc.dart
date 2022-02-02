import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class ThemeModeBloc extends Bloc<ThemeModeEvents, ThemeModeState> {
  ThemeModeBloc({required ThemeModeState initialState}) : super(initialState) {
    on<SetLightTheme>(_onSetLightTheme);
    on<SetDarkTheme>(_onSetDarkTheme);
    on<SetSystemTheme>(_onSetSystemTheme);
  }

  _onSetLightTheme(SetLightTheme event, Emitter<ThemeModeState> emitter) {
    ThemeMode _themeMode = ThemeMode.light;
    ThemeModeState _themeModeState = ThemeModeState(themeMode: _themeMode);
    emitter.call(_themeModeState);
  }

  _onSetDarkTheme(SetDarkTheme event, Emitter<ThemeModeState> emitter) {
    ThemeMode _themeMode = ThemeMode.dark;
    ThemeModeState _themeModeState = ThemeModeState(themeMode: _themeMode);
    emitter.call(_themeModeState);
  }

  _onSetSystemTheme(SetSystemTheme event, Emitter<ThemeModeState> emitter) {
    ThemeMode _themeMode = ThemeMode.system;
    ThemeModeState _themeModeState = ThemeModeState(themeMode: _themeMode);
    emitter.call(_themeModeState);
  }
}
