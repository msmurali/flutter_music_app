import 'package:flutter/material.dart';
import 'package:music/src/data/providers/recents_provider.dart';
import 'package:music/src/data/providers/songs_provider.dart';
import 'package:music/src/interface/widgets/loading_indicator.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'circular_tile.dart';
import 'error_indicator.dart';

class Recents extends StatefulWidget {
  const Recents({Key? key}) : super(key: key);

  @override
  State<Recents> createState() => _RecentsState();
}

class _RecentsState extends State<Recents> {
  final RecentsProvider _recentsProvider = RecentsProvider();
  final SongsProvider _songsProvider = SongsProvider();

  @override
  Widget build(BuildContext context) {
    // if (_recents.isEmpty) {
    //   return const SizedBox(
    //     height: 300,
    //     child: ErrorIndicator(
    //       asset: 'asset/images/no_recents.svg',
    //     ),
    //   );
    // } else {
    //   return SizedBox(
    //     height: 200,
    //     child: ListView.builder(
    //       itemCount: 20,
    //       itemBuilder: (BuildContext context, int index) {
    //         return CircularTile(
    //           song: _recents[index],
    //         );
    //       },
    //     ),
    //   );
    // }
    return FutureBuilder(
      future: _songsProvider.getSongs(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) {
                return CircularTile(
                  song: snapshot.data[index],
                );
              },
            ),
          );
        } else {
          return const LoadingIndicator();
        }
      },
    );
  }
}
