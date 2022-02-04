import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:music/src/interface/utils/custom_icons.dart';
import 'package:music/src/interface/widgets/circular_artwork.dart';
import 'package:music/src/interface/widgets/circular_icon_button.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Background extends StatelessWidget {
  final Uint8List? imageData;
  const Background({Key? key, this.imageData}) : super(key: key);

  _getImage() {
    if (imageData == null) {
      return const AssetImage('asset/images/placeholder.jpg');
    } else {
      return MemoryImage(imageData!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: _getImage(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(0.01),
                    Colors.white.withOpacity(0.02),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

class Info extends StatelessWidget {
  final SongModel song;
  const Info({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          song.title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        Text(
          song.artist ?? 'Unknown Artist',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }
}

class Foreground extends StatelessWidget {
  final SongModel song;
  const Foreground({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 32.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Info(song: song),
          const CircularArtwork(
            radius: 150,
          ),
          const PlayerControlPanel(),
        ],
      ),
    );
  }
}

class Player extends StatelessWidget {
  const Player({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: const [
          Background(),
        ],
      ),
      height: MediaQuery.of(context).size.height,
    );
  }
}

class PlayerControlPanel extends StatelessWidget {
  const PlayerControlPanel({Key? key}) : super(key: key);

  _buildProgressBar() {
    return Column(
      children: [
        Slider(
          value: 0.5,
          onChanged: (val) {},
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0:00',
              ),
              Text(
                '3:56',
              ),
            ],
          ),
        ),
      ],
    );
  }

  _buildControls() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 36.0, top: 36.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(CustomIcons.shuffle),
            iconSize: 16,
          ),
          CircularIconButton(
            child: const Icon(CustomIcons.previous),
            radius: 25.0,
            iconSize: 18.0,
            onPressed: () {},
          ),
          CircularIconButton(
            child: const Align(
              alignment: Alignment(0.8, -0.3),
              child: Icon(CustomIcons.play),
            ),
            radius: 30.0,
            onPressed: () {},
          ),
          CircularIconButton(
            child: const Icon(CustomIcons.next),
            radius: 25.0,
            iconSize: 18.0,
            onPressed: () {},
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(CustomIcons.heart_outline),
            iconSize: 16,
          ),
        ],
      ),
    );
  }

  _buildBottomPanel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(CustomIcons.add_to_playlist),
          onPressed: () {},
          iconSize: 20.0,
        ),
        IconButton(
          icon: const Icon(CustomIcons.play),
          onPressed: () {},
          iconSize: 20.0,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildProgressBar(),
        _buildControls(),
        _buildBottomPanel(),
      ],
    );
  }
}
