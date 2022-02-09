import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music/src/logic/bloc/recents_bloc/bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
            height: 200,
            child: ListView.builder(
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return CircularTile(
                  song: _recents[index],
                );
              },
            ),
          );
        }
      },
    );
  }
}
