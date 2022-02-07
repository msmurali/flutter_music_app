import 'package:flutter/material.dart';

const Color darkPrimary = Color(0xFF121212);
const Color darkPrimaryLight = Color(0xFF353535);
const Color darkSecondary = Color(0xFFE4E4E4);

const Color lightPrimary = Color(0xFFFFFFFF);
const Color lightPrimaryLight = Colors.white70;
const Color lightSecondary = Color(0xFF121212);

const Color onSurface = Color(0xFFF50057);

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
    labelColor: onSurface,
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
    background: darkPrimary,
    error: Colors.red,
    onError: Colors.white,
    surface: darkPrimaryLight,
    brightness: Brightness.dark,
    onBackground: darkSecondary,
    onPrimary: darkSecondary,
    onSecondary: darkPrimary,
    onSurface: onSurface,
    secondary: darkSecondary,
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
      fontSize: 13.0,
      fontWeight: FontWeight.w400,
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
  // splashColor: Colors.transparent,
  dialogTheme: const DialogTheme(
    backgroundColor: Color(0xFF181818),
    elevation: 20.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: darkSecondary,
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20.0,
          ),
        ),
      ),
      foregroundColor: MaterialStateProperty.all(
        onSurface,
      ),
      backgroundColor: MaterialStateProperty.all(
        Colors.transparent,
      ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: 8.0,
        ),
      ),
    ),
  ),
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
    labelColor: onSurface,
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
    background: lightPrimary,
    error: Colors.red,
    onError: Colors.white,
    surface: lightPrimaryLight,
    brightness: Brightness.light,
    onBackground: lightSecondary,
    onPrimary: lightSecondary,
    onSecondary: lightPrimary,
    onSurface: onSurface,
    secondary: lightSecondary,
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
  dialogTheme: const DialogTheme(
    backgroundColor: lightPrimary,
    elevation: 10.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 18.0,
      fontWeight: FontWeight.w400,
      color: darkSecondary,
    ),
    contentTextStyle: TextStyle(
      fontFamily: 'Poppins',
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      color: darkSecondary,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);
