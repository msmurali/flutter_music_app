import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:music/src/interface/utils/custom_icons.dart';
import 'package:music/src/interface/widgets/circular_artwork.dart';
import 'package:music/src/interface/widgets/circular_icon_button.dart';
import 'package:music/src/interface/widgets/circular_progress_bar.dart';

class MiniPlayer extends StatelessWidget {
  const MiniPlayer({Key? key}) : super(key: key);

  Widget _buildBackground() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 4.0,
          sigmaY: 4.0,
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.1,
              color: Colors.white.withOpacity(0.4),
            ),
            borderRadius: BorderRadius.circular(8.0),
            gradient: const LinearGradient(
              colors: [
                Color(0x3F3A3A3A),
                Color(0x18333333),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForeground(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 12.0,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(28.0),
            child: Container(
              width: 56.0,
              height: 56.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    'asset/images/placeholder.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Havana',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    'Camila Cabello',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: [
              CircularIconButton(
                  child: const Icon(CustomIcons.previous),
                  onPressed: () {},
                  iconSize: 10.0,
                  radius: 14.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: GestureDetector(
                  onTap: () {},
                  child: const CircularProgressBar(
                    activeColor: Colors.white,
                    inActiveColor: Colors.grey,
                    radius: 20.0,
                    trackWidth: 2.5,
                    progress: 0.7,
                    child: Icon(
                      CustomIcons.pause,
                      size: 15.0,
                    ),
                  ),
                ),
              ),
              CircularIconButton(
                child: const Icon(CustomIcons.next),
                onPressed: () {},
                iconSize: 10.0,
                radius: 14.0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88.0,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            _buildBackground(),
            _buildForeground(context),
          ],
        ),
      ),
    );
  }
}
