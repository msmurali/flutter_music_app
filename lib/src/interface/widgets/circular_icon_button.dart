import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final Widget child;
  final double radius;
  final String? toolTip;
  final void Function() onPressed;
  final double? iconSize;
  final Color? backgroundColor;

  const CircularIconButton({
    Key? key,
    required this.child,
    required this.radius,
    required this.onPressed,
    this.iconSize,
    this.toolTip,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor ?? Colors.white.withOpacity(0.05),
      ),
      child: Center(
        child: IconButton(
          iconSize: iconSize ?? 24.0,
          icon: child,
          onPressed: onPressed,
          tooltip: toolTip,
        ),
      ),
    );
  }
}
