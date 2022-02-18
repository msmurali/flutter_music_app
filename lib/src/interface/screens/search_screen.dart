import 'dart:async';

import 'package:flutter/material.dart' hide BackButton;

import '../../data/providers/songs_provider.dart';
import '../utils/custom_icons.dart';
import '../widgets/back_button.dart';
import '../widgets/circular_icon_button.dart';
import '../widgets/error_indicator.dart';
import '../widgets/mini_player.dart';
import '../widgets/music_tab.dart';
import '../widgets/scaffold_with_sliding_panel.dart';
import 'player_screen.dart';

final TextEditingController _textEditingController = TextEditingController();
final SongsProvider _songsProvider = SongsProvider();

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Timer? _debounce;
  String query = '';
  Widget results = const SizedBox();

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(_onQueryChanged);
  }

  _onQueryChanged() {
    if (_debounce?.isActive ?? false) {
      _debounce!.cancel();
    }
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        query = _textEditingController.text;
        results = buildResults();
      });
    });
  }

  Widget buildResults() {
    return MusicTab(
      futureData: _songsProvider.searchSongs(query),
      errorIndicator: const ErrorIndicator(
        asset: 'asset/images/no_results.svg',
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 56.0,
      leading: const BackButton(),
      title: SearchField(
        controller: _textEditingController,
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16.0),
          child: CircularIconButton(
            child: const SizedBox(
              child: Icon(CustomIcons.search),
              width: 18.0,
            ),
            radius: 20.0,
            onPressed: () {},
            iconSize: 18.0,
            toolTip: 'Search',
          ),
        )
      ],
    );
  }

  Widget _buildSearchScreen(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: results,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: ScaffoldWithSlidingPanel(
          body: _buildSearchScreen(context),
          collapsed: const MiniPlayer(),
          expanded: const PlayerScreen(),
        ),
      ),
    );
  }
}

class SearchField extends StatefulWidget {
  final TextEditingController controller;

  const SearchField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  _SearchFieldState createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final FocusNode _focusNode = FocusNode();

  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() => _hasFocus = _focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(100.0),
      child: Material(
        color: Colors.transparent,
        child: TextField(
          textInputAction: TextInputAction.search,
          controller: widget.controller,
          autofocus: true,
          cursorColor: theme.colorScheme.onSurface,
          focusNode: _focusNode,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 12.0,
            ),
            isDense: true,
            filled: true,
            fillColor: theme.colorScheme.secondary.withOpacity(0.05),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
