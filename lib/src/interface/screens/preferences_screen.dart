import 'package:flutter/material.dart';
import '../widgets/sorting_preferences.dart';
import '../widgets/view_preferences.dart';
import '../widgets/theme_preferences.dart';
import '../widgets/app_bar_button.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      leading: AppBarButton(
        margin: const EdgeInsets.only(left: 16.0),
        radius: 20.0,
        tooltip: 'Back',
        child: const Padding(
          padding: EdgeInsets.only(
            left: 6.0,
          ),
          child: Icon(
            Icons.arrow_back_ios,
          ),
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'Settings',
        style: theme.textTheme.headline6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ThemePreferences(),
                ViewPreferences(),
                SortingPreferences(),
              ],
            ),
          ),
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
