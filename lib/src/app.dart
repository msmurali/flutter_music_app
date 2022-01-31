import 'package:flutter/material.dart';
import 'package:music/src/global/constants/constants.dart';
import 'package:music/src/global/constants/enums.dart';
import 'package:music/src/interface/router/app_router.dart';
import 'package:music/src/data/services/app_permissions.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();
    _getStorageAccessPermission();
  }

  _getStorageAccessPermission() async {
    await AppPermissions.requestPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music',
      theme: ThemeData(
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF121212),
          foregroundColor: Color(0xFFE4E4E4),
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Color(0xFFD3D3D3),
          ),
          actionsIconTheme: IconThemeData(
            color: Color(0xFFE4E4E4),
          ),
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 22.0,
            color: Color(0xFFE4E4E4),
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        tabBarTheme: TabBarTheme(
          labelColor: Colors.pinkAccent.shade400,
          unselectedLabelColor: const Color(0xFFE4E4E4),
          labelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
          ),
          unselectedLabelStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.0,
            fontWeight: FontWeight.w300,
          ),
          indicatorSize: TabBarIndicatorSize.label,
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
        listTileTheme: const ListTileThemeData(
          tileColor: Color(0xFF121212),
          dense: true,
          iconColor: Color(0xFFE4E4E4),
          textColor: Color(0xFFE4E4E4),
        ),
        colorScheme: ColorScheme(
          primary: const Color(0xFF121212),
          primaryVariant: Colors.black,
          background: const Color(0xFF121212),
          error: Colors.red,
          onError: Colors.white,
          surface: Colors.grey[700]!,
          brightness: Brightness.dark,
          onBackground: const Color(0xFFE4E4E4),
          onPrimary: const Color(0xFFE4E4E4),
          onSecondary: const Color(0xFFE4E4E4),
          onSurface: Colors.white,
          secondary: Colors.grey[700]!,
          secondaryVariant: Colors.grey[500]!,
        ),
        textTheme: const TextTheme(
          headline6: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 20.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFFE4E4E4),
          ),
          bodyText2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14.0,
            fontWeight: FontWeight.w400,
            color: Color(0xFFE4E4E4),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle1: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12.0,
            fontWeight: FontWeight.w300,
            color: Color(0xFFE4E4E4),
            overflow: TextOverflow.ellipsis,
          ),
          subtitle2: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 10.0,
            fontWeight: FontWeight.w300,
            color: Color(0xFFE4E4E4),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        sliderTheme: const SliderThemeData(
          overlayColor: Colors.transparent,
          trackShape: RoundedRectSliderTrackShape(),
          trackHeight: 1.2,
          activeTrackColor: Colors.white,
          inactiveTrackColor: Color(0xFF959595),
          thumbColor: Colors.white,
          thumbShape: RoundSliderThumbShape(
            enabledThumbRadius: 8.0,
          ),
          overlayShape: RoundSliderOverlayShape(overlayRadius: 0.0),
        ),
        splashColor: Colors.transparent,
      ),
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: routes[Routes.homeRoute],
    );
  }
}
