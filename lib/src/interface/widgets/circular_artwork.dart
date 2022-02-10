import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/placeholder_image.dart';

class CircularArtwork extends StatelessWidget {
  final Uint8List? imageData;
  final double radius;

  const CircularArtwork({
    Key? key,
    required this.radius,
    this.imageData,
  }) : super(key: key);

  _getArtworkImage() {
    if (imageData == null) {
      return const PlaceholderImage();
    } else {
      return Image.memory(
        imageData!,
        fit: BoxFit.cover,
        gaplessPlayback: true,
        errorBuilder: (
          BuildContext context,
          Object exception,
          StackTrace? stackTrace,
        ) =>
            const PlaceholderImage(),
      );
    }
  }

  Widget _buildCircularImage(double diameter) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(diameter / 2),
      child: SizedBox(
        width: diameter,
        height: diameter,
        child: Container(
          child: _getArtworkImage(),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget _buildCircularBorder(double diameter) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 0.2,
          color: Colors.white.withOpacity(0.5),
        ),
      ),
    );
  }

  Widget _buildRadialGradientContainer(double diameter) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.2),
          ],
          stops: const [0.9, 1.0],
        ),
      ),
    );
  }

  Widget _buildBlurredContainer(double diameter) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(diameter),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 8.0,
          sigmaY: 8.0,
        ),
        child: Container(
          width: diameter,
          height: diameter,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildCircularImage(radius * 2),
          _buildBlurredContainer(radius * 2.04),
          _buildCircularBorder(radius * 1.92),
          _buildCircularBorder(radius * 1.75),
          _buildCircularImage(radius * 1.6),
          _buildRadialGradientContainer(radius * 1.6),
        ],
      ),
    );
  }
}
