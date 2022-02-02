import 'package:flutter/material.dart';

const Color darkPrimary = Color(0xFF121212);
const Color darkPrimaryLight = Color(0xFF353535);
const Color darkSecondary = Color(0xFFE4E4E4);

const Color lightPrimary = Color(0xFFFFFFFF);
const Color lightPrimaryLight = Colors.white70;
const Color lightSecondary = Color(0xFF121212);

const Color onPrimary = Color(0xFFF50057);

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  appBarTheme: const AppBarTheme(
    backgroundColor: darkPrimary,
    foregroundColor: darkSecondary,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: darkSecondary,
    ),
    actionsIconTheme: IconThemeData(
      color: darkSecondary,
    ),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18.0,
      color: darkSecondary,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: onPrimary,
    unselectedLabelColor: darkSecondary,
    labelStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    indicatorSize: TabBarIndicatorSize.label,
  ),
  scaffoldBackgroundColor: darkPrimary,
  listTileTheme: const ListTileThemeData(
    tileColor: darkPrimary,
    // selectedTileColor: ,
    dense: true,
    iconColor: darkSecondary,
    textColor: darkSecondary,
  ),
  colorScheme: const ColorScheme(
    primary: darkPrimary,
    primaryVariant: Colors.black,
    background: darkPrimary,
    error: Colors.red,
    onError: Colors.white,
    surface: darkPrimaryLight,
    brightness: Brightness.dark,
    onBackground: darkSecondary,
    onPrimary: darkSecondary,
    onSecondary: darkPrimary,
    onSurface: Colors.white,
    secondary: darkSecondary,
    secondaryVariant: Colors.grey,
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: darkSecondary,
    ),
    bodyText2: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: darkSecondary,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle1: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
      color: darkSecondary,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle2: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 10.0,
      fontWeight: FontWeight.w300,
      color: darkSecondary,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  sliderTheme: SliderThemeData(
    overlayColor: Colors.transparent,
    trackShape: const RoundedRectSliderTrackShape(),
    trackHeight: 1.2,
    activeTrackColor: Colors.white,
    inactiveTrackColor: Colors.grey.shade300, // TODO:
    thumbColor: Colors.white,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: 8.0,
    ),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
  ),
  splashColor: Colors.transparent,
);

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: lightPrimary,
    foregroundColor: lightSecondary,
    elevation: 0.0,
    iconTheme: IconThemeData(
      color: lightSecondary,
    ),
    actionsIconTheme: IconThemeData(
      color: lightSecondary,
    ),
    centerTitle: true,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18.0,
      color: lightSecondary,
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  tabBarTheme: const TabBarTheme(
    labelColor: onPrimary,
    unselectedLabelColor: lightSecondary,
    labelStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    unselectedLabelStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    ),
    indicatorSize: TabBarIndicatorSize.label,
  ),
  scaffoldBackgroundColor: lightPrimary,
  listTileTheme: const ListTileThemeData(
    tileColor: lightPrimary,
    // selectedTileColor: ,
    dense: true,
    iconColor: lightSecondary,
    textColor: lightSecondary,
  ),
  colorScheme: const ColorScheme(
    primary: lightPrimary,
    primaryVariant: Colors.white,
    background: lightPrimary,
    error: Colors.red,
    onError: Colors.white,
    surface: lightPrimaryLight,
    brightness: Brightness.light,
    onBackground: lightSecondary,
    onPrimary: lightSecondary,
    onSecondary: lightPrimary,
    onSurface: Colors.black,
    secondary: lightSecondary,
    secondaryVariant: Colors.grey,
  ),
  textTheme: const TextTheme(
    headline6: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: lightSecondary,
    ),
    bodyText2: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: lightSecondary,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle1: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 12.0,
      fontWeight: FontWeight.w300,
      color: lightSecondary,
      overflow: TextOverflow.ellipsis,
    ),
    subtitle2: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 10.0,
      fontWeight: FontWeight.w300,
      color: lightSecondary,
      overflow: TextOverflow.ellipsis,
    ),
  ),
  sliderTheme: SliderThemeData(
    overlayColor: Colors.transparent,
    trackShape: const RoundedRectSliderTrackShape(),
    trackHeight: 1.2,
    activeTrackColor: Colors.white,
    inactiveTrackColor: Colors.grey.shade300, // TODO:
    thumbColor: Colors.white,
    thumbShape: const RoundSliderThumbShape(
      enabledThumbRadius: 8.0,
    ),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 0.0),
  ),
  splashColor: Colors.transparent,
);
