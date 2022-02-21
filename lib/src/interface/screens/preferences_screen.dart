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

  Widget _getDivider() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Divider(
        height: 10.0,
        color: Colors.grey[300],
        thickness: 0.1,
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
              children: [
                const ThemePreferences(),
                _getDivider(),
                const ViewPreferences(),
                _getDivider(),
                const SortingPreferences(),
              ],
            ),
          ),
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
