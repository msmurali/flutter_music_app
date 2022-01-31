import 'package:flutter/material.dart';
import 'package:music/src/global/constants/constants.dart';
import 'package:music/src/global/constants/enums.dart';
import 'package:music/src/interface/utils/custom_icons.dart';
import 'package:music/src/interface/widgets/circular_icon_button.dart';
import 'package:music/src/interface/widgets/music_tab.dart';
import 'package:music/src/data/providers/songs_provider.dart';

class MusicLibrary extends StatelessWidget {
  final SongsProvider _songsProvider = SongsProvider();

  MusicLibrary({Key? key}) : super(key: key);

  AppBar _buildAppBar(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return AppBar(
      title: Text(
        'Library',
        style: theme.textTheme.headline6,
      ),
      centerTitle: true,
      leadingWidth: 56.0,
      leading: _buildPreferencesButton(context),
      actions: [
        _buildSearchButton(),
      ],
      bottom: _buildTabBar(),
    );
  }

  Container _buildSearchButton() {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: CircularIconButton(
        child: const SizedBox(
          child: Icon(CustomIcons.search),
          width: 18.0,
        ),
        radius: 20.0,
        onPressed: () {}, // TODO
        iconSize: 18.0,
        toolTip: 'Search',
      ),
    );
  }

  Container _buildPreferencesButton(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      child: CircularIconButton(
        child: const SizedBox(
          child: Icon(CustomIcons.menu),
          width: 18.0,
        ),
        radius: 20.0,
        onPressed: () {
          Navigator.pushNamed(
            context,
            routes[Routes.preferencesRoute]!,
          );
        },
        iconSize: 16.0,
        toolTip: 'Preferences',
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      indicatorColor: Colors.pinkAccent.shade400,
      indicatorWeight: 1.4,
      isScrollable: true,
      tabs: const [
        Tab(text: 'Home'),
        Tab(text: 'Songs'),
        Tab(text: 'Artists'),
        Tab(text: 'Albums'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: _buildAppBar(context),
          body: TabBarView(
            children: [
              Container(color: Colors.white),
              MusicTab(
                futureData: _songsProvider.getSongs(),
              ),
              MusicTab(
                futureData: _songsProvider.getArtists(),
              ),
              MusicTab(
                futureData: _songsProvider.getAlbums(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
