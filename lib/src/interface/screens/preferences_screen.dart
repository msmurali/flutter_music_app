import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/view_preferences.dart';
import '../../interface/widgets/preferences_option.dart';
import '../../interface/widgets/theme_preferences.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../global/constants/constants.dart';
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
              children: [
                const ThemePreferences(),
                ViewPreferences(),
                PreferencesDropDown(
                  title: 'Sort by',
                  value: 'Name',
                  options: SongSortType.values
                      .map((sortType) => sortType.name)
                      .toList(),
                ),
                PreferencesDropDown(
                  title: 'Order by',
                  value: 'ASC',
                  options: OrderType.values
                      .map((orderType) => orderType.name)
                      .toList(),
                ),
              ],
            ),
          ),
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}

class PreferencesDropDown extends StatelessWidget {
  final String title;
  final String value;
  final List<String> options;

  const PreferencesDropDown({
    Key? key,
    required this.title,
    required this.value,
    required this.options,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          const SizedBox(height: 20.0),
          Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                width: 1.4,
                color: Colors.pinkAccent.shade400,
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: Text(
                  value,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                items: options
                    .map(
                      (option) => DropdownMenuItem<String>(
                        value: option,
                        child: Text(
                          option,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (String? val) {
                  print(val);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
