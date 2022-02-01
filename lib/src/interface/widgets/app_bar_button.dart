import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/circular_icon_button.dart';

class AppBarButton extends StatelessWidget {
  final Color? backgroundColor;
  final String tooltip;
  final double radius;
  final EdgeInsets? margin;
  final Widget child;
  final void Function()? onPressed;
  final double? iconSize;

  const AppBarButton({
    Key? key,
    required this.child,
    required this.radius,
    required this.tooltip,
    this.backgroundColor,
    this.margin,
    this.onPressed,
    this.iconSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: CircularIconButton(
        child: child,
        radius: radius,
        onPressed: onPressed,
        iconSize: iconSize,
        toolTip: tooltip,
        backgroundColor: backgroundColor,
      ),
    );
  }
}
