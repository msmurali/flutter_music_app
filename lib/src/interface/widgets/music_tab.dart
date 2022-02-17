import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../global/constants/index.dart';
import '../../logic/bloc/player_bloc/bloc.dart';
import '../utils/helpers.dart';
import '../../logic/bloc/preferences_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'error_indicator.dart';
import 'loading_indicator.dart';
import 'tile.dart';

class MusicTab extends StatefulWidget {
  final Future<List<dynamic>> futureData;
  final Widget? errorIndicator;

  const MusicTab({
    Key? key,
    required this.futureData,
    this.errorIndicator,
  }) : super(key: key);

  @override
  State<MusicTab> createState() => _MusicTabState();
}

class _MusicTabState extends State<MusicTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder(
      future: widget.futureData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return MusicList(
          snapshot: snapshot,
          errorIndicator: widget.errorIndicator,
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MusicList extends StatelessWidget {
  final AsyncSnapshot snapshot;
  final Widget? errorIndicator;

  const MusicList({Key? key, required this.snapshot, this.errorIndicator})
      : super(key: key);

  Widget _buildList(BuildContext context, List<dynamic> data) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildTile(context, data[index], index);
      },
    );
  }

  Widget _buildGrid(BuildContext context, List<dynamic> data) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: BlocBuilder<PreferencesBloc, PreferencesState>(
        buildWhen: (PreferencesState previous, PreferencesState current) {
          return previous.gridSize != current.gridSize;
        },
        builder: (context, state) {
          int _gridSize =
              BlocProvider.of<PreferencesBloc>(context).state.gridSize;
          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: data.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _gridSize,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemBuilder: (BuildContext context, int index) {
              return _buildTile(context, data[index], index);
            },
          );
        },
      ),
    );
  }

  Widget _buildTile(BuildContext context, dynamic entity, int index) {
    if (entity is SongModel) {
      return Tile(
        entity: entity,
        onTap: () async {
          BlocProvider.of<PlayerBloc>(context).add(
            ChangeQueueList(
              queue: snapshot.data,
              index: index,
              context: context,
            ),
          );
        },
        onLongPress: (dynamic details) async {
          await showMenuDialog(context, details, entity, songOptions);
        },
      );
    } else if (entity is AlbumModel) {
      return Tile(
        entity: entity,
        onTap: () {
          _navigateToSongsScreen(context, entity);
        },
        onLongPress: (dynamic details) async {
          await showMenuDialog(context, details, entity, albumOptions);
        },
      );
    } else if (entity is ArtistModel) {
      return Tile(
        entity: entity,
        onTap: () {
          _navigateToSongsScreen(context, entity);
        },
        onLongPress: (dynamic details) async {
          await showMenuDialog(context, details, entity, artistOptions);
        },
      );
    } else {
      return Tile(
        entity: entity,
        onTap: () {
          _navigateToSongsScreen(context, entity);
        },
        onLongPress: (dynamic details) async {
          await showMenuDialog(
              context,
              details,
              {
                'playlistName': snapshot.data.name,
                'song': entity,
              },
              playlistOptions);
        },
      );
    }
  }

  void _navigateToSongsScreen(BuildContext context, dynamic entity) {
    Navigator.pushNamed(
      context,
      routes[Routes.songsRoute]!,
      arguments: entity,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const LoadingIndicator();
    } else if (snapshot.hasData && snapshot.data != null) {
      List<dynamic> data = snapshot.data;
      return BlocBuilder<PreferencesBloc, PreferencesState>(
        buildWhen: (PreferencesState previous, PreferencesState current) {
          return (previous.view != current.view ||
              previous.gridSize != current.gridSize);
        },
        builder: (BuildContext context, PreferencesState state) {
          if (state.view == View.list) {
            return _buildList(context, data);
          } else {
            return _buildGrid(context, data);
          }
        },
      );
    } else {
      return errorIndicator ??
          const ErrorIndicator(
            asset: 'asset/images/no_data_error.svg',
          );
    }
  }
}
