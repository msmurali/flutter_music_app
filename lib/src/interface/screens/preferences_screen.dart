import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/circular_icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreferencesScreen extends StatelessWidget {
  const PreferencesScreen({Key? key}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      leading: _buildBackButton(context),
      title: Text(
        'Settings',
        style: theme.textTheme.headline6,
      ),
    );
  }

  Container _buildBackButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      child: CircularIconButton(
        child: const Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Icon(Icons.arrow_back_ios),
        ),
        radius: 20.0,
        onPressed: () {
          Navigator.pop(context);
        },
        iconSize: 16.0,
        toolTip: 'Back',
      ),
    );
  }

  _buildThemePreferences(BuildContext context) {
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
          children: [
            _buildOption(
              context: context,
              asset: 'asset/images/light_theme.svg',
              title: 'Light',
            ),
            _buildOption(
              context: context,
              asset: 'asset/images/dark_theme.svg',
              title: 'Dark',
            ),
            _buildOption(
              context: context,
              asset: 'asset/images/system_theme.svg',
              title: 'System',
            ),
          ],
        ),
      ],
    );
  }

  Container _buildOption({
    required BuildContext context,
    required String asset,
    required String title,
  }) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.pinkAccent.shade400,
          width: 1.4,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 80.0,
            width: 80.0,
            child: SvgPicture.asset(
              asset,
            ),
          ),
          Text(
            title,
            style: theme.textTheme.subtitle1,
          ),
        ],
      ),
    );
  }

  Container _buildGridSizeOption(
      {required BuildContext context, required String title}) {
    ThemeData theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: theme.textTheme.subtitle1,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(
          color: Colors.pinkAccent.shade400,
          width: 1.4,
        ),
      ),
    );
  }

  Padding _buildViewPreferences(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
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
            children: [
              _buildOption(
                context: context,
                asset: 'asset/images/light_theme.svg',
                title: 'List',
              ),
              const SizedBox(width: 12.0),
              _buildOption(
                context: context,
                asset: 'asset/images/dark_theme.svg',
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
                  _buildGridSizeOption(
                    context: context,
                    title: '2',
                  ),
                  const SizedBox(width: 20.0),
                  _buildGridSizeOption(
                    context: context,
                    title: '3',
                  ),
                  const SizedBox(width: 20.0),
                  _buildGridSizeOption(
                    context: context,
                    title: '4',
                  ),
                  const SizedBox(width: 20.0),
                  _buildGridSizeOption(
                    context: context,
                    title: '5',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildSortPreferences(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sort by',
          style: theme.textTheme.bodyText2,
        ),
        const SizedBox(height: 20.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              width: 1.4,
              color: Colors.pinkAccent.shade400,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: 'Name',
              items: [
                _buildDropDownOption(context: context, title: 'Name'),
                _buildDropDownOption(context: context, title: 'Date Added'),
                _buildDropDownOption(context: context, title: 'Duration'),
              ],
              onChanged: (String? val) {},
            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }

  _buildOrderPreferences(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Order by',
          style: theme.textTheme.bodyText2,
        ),
        const SizedBox(height: 20.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              width: 1.4,
              color: Colors.pinkAccent.shade400,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: 'Name',
              items: [
                _buildDropDownOption(context: context, title: 'Name'),
                _buildDropDownOption(context: context, title: 'Date Added'),
                _buildDropDownOption(context: context, title: 'Duration'),
              ],
              onChanged: (String? val) {},
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> _buildDropDownOption({
    required BuildContext context,
    required String title,
  }) {
    ThemeData theme = Theme.of(context);
    return DropdownMenuItem(
      value: title,
      child: Text(
        title,
        style: theme.textTheme.bodyText2,
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
                _buildThemePreferences(context),
                _buildViewPreferences(context),
                _buildSortPreferences(context),
                _buildOrderPreferences(context),
              ],
            ),
          ),
          physics: const BouncingScrollPhysics(),
        ),
      ),
    );
  }
}
