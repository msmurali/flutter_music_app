import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/mini_player.dart';
import 'package:music/src/interface/widgets/music_library.dart';
import 'package:music/src/interface/widgets/scaffold_with_sliding_panel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ScaffoldWithSlidingPanel(
          body: const MusicLibrary(),
          collapsed: const MiniPlayer(),
          expanded: Container(color: Colors.white),
        ),
      ),
    );
  }
}
