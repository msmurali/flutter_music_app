import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  final Widget child;
  final double radius;
  final String? toolTip;
  final void Function()? onPressed;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? color;

  const CircularIconButton({
    Key? key,
    required this.child,
    required this.radius,
    this.onPressed,
    this.iconSize,
    this.toolTip,
    this.backgroundColor,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.05),
      ),
      child: Center(
        child: IconButton(
          color: color,
          iconSize: iconSize ?? 24.0,
          icon: child,
          onPressed: onPressed,
          tooltip: toolTip,
        ),
      ),
    );
  }
}
