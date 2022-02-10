import 'package:flutter/material.dart';

class PlaceholderImage extends StatelessWidget {
  const PlaceholderImage({Key? key}) : super(key: key);

  final placeholderImage = 'asset/images/placeholder.jpg';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      placeholderImage,
      fit: BoxFit.cover,
      alignment: Alignment.topCenter,
      gaplessPlayback: true,
    );
  }
}
