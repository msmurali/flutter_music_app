import 'package:flutter/material.dart';

import '../utils/custom_icons.dart';

class CustomListTile extends StatelessWidget {
  final Widget artwork;
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final void Function(dynamic)? onTrailingPressed;
  final dynamic entity;

  const CustomListTile({
    Key? key,
    required this.artwork,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onTrailingPressed,
    required this.entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListTile(
        visualDensity: const VisualDensity(vertical: 2),
        leading: artwork,
        title: Text(
          title,
          style: theme.textTheme.bodyText2,
          maxLines: 1,
        ),
        subtitle: Text(
          subtitle,
          style: theme.textTheme.subtitle2,
          maxLines: 1,
        ),
        trailing: GestureDetector(
          onTapDown: onTrailingPressed,
          child: const SizedBox(
            width: 40.0,
            height: 40.0,
            child: Icon(
              CustomIcons.more,
              size: 18.0,
            ),
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
