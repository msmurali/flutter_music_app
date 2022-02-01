import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/app_bar_button.dart';
import 'package:music/src/global/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:on_audio_query/on_audio_query.dart';

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

class ThemePreferences extends StatelessWidget {
  const ThemePreferences({Key? key}) : super(key: key);

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            PreferencesOption(
              active: false,
              asset: 'asset/images/light_theme.svg',
              title: 'Light',
            ),
            PreferencesOption(
              active: true,
              asset: 'asset/images/dark_theme.svg',
              title: 'Dark',
            ),
            PreferencesOption(
              active: false,
              asset: 'asset/images/system_theme.svg',
              title: 'System',
            ),
          ],
        ),
      ],
    );
  }
}

class ViewPreferences extends StatelessWidget {
  ViewPreferences({Key? key}) : super(key: key);

  final gridSizeOptionWidgets = gridSizes
      .map((size) => Row(
            children: [
              const SizedBox(width: 20.0),
              PreferencesOption(
                active: true,
                title: size.toString(),
              ),
            ],
          ))
      .toList();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'View',
            style: theme.textTheme.bodyText2,
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              PreferencesOption(
                active: false,
                asset: 'asset/images/list_view.svg',
                title: 'List',
              ),
              SizedBox(width: 12.0),
              PreferencesOption(
                active: true,
                asset: 'asset/images/grid_view.svg',
                title: 'Grid',
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Number of tiles in\na row',
                    style: theme.textTheme.subtitle1,
                  ),
                  const Spacer(),
                  ...gridSizeOptionWidgets,
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PreferencesOption extends StatelessWidget {
  final String? asset;
  final String title;
  final bool active;

  const PreferencesOption({
    Key? key,
    this.asset,
    required this.active,
    required this.title,
  }) : super(key: key);

  Column _buildAsset() {
    return Column(
      children: [
        SizedBox(
          height: 80.0,
          width: 80.0,
          child: SvgPicture.asset(
            asset!,
          ),
        ),
        const SizedBox(
          height: 5.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: active ? Colors.pinkAccent.shade400 : Colors.transparent,
          width: 1.4,
        ),
      ),
      child: Column(
        children: [
          asset != null ? _buildAsset() : const SizedBox(),
          Text(
            title,
            style: theme.textTheme.subtitle1,
          ),
        ],
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
