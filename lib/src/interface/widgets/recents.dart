import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../logic/bloc/recents_bloc/bloc.dart';
import 'circular_tile.dart';
import 'error_indicator.dart';

class Recents extends StatefulWidget {
  const Recents({Key? key}) : super(key: key);

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentsBloc, RecentsState>(
      builder: (context, state) {
        List<SongModel> _recents = state.songs;
        if (_recents.isEmpty) {
          return const SizedBox(
            height: 300,
            child: ErrorIndicator(
              asset: 'asset/images/no_recents.svg',
            ),
          );
        } else {
          return SizedBox(
            height: 170,
            child: RecentsList(recents: _recents),
          );
        }
      },
    );
  }
}

class RecentsList extends StatelessWidget {
  const RecentsList({
    Key? key,
    required this.recents,
  }) : super(key: key);

  final List<SongModel> recents;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) => CircularTile(
        song: recents[index],
      ),
      itemCount: recents.length,
      primary: true,
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
    );
  }
}
