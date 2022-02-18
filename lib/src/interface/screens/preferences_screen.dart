import 'package:flutter/material.dart' hide BackButton;

import '../widgets/back_button.dart';
import '../widgets/sorting_preferences.dart';
import '../widgets/theme_preferences.dart';
import '../widgets/view_preferences.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      leading: const BackButton(),
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
