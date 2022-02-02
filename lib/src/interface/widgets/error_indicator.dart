import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorIndicator extends StatelessWidget {
  final String asset;

  const ErrorIndicator({Key? key, required this.asset}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        asset,
      ),
    );
  }
}
