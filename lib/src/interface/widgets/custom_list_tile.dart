import 'package:flutter/material.dart';
import 'package:music/src/interface/utils/custom_icons.dart';
import 'package:music/src/interface/utils/helpers.dart';

class CustomListTile extends StatelessWidget {
  final Widget artwork;
  final String title;
  final String subtitle;
  final void Function()? onTap;
  final void Function() onTrailingPressed;

  const CustomListTile({
    Key? key,
    required this.artwork,
    required this.title,
    required this.subtitle,
    required this.onTap,
    required this.onTrailingPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return ListTile(
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
        onTapDown: (details) async {
          showMenuDialog(context, details);
        },
        child: const Icon(
          CustomIcons.more,
          size: 18.0,
        ),
      ),
      onTap: onTap,
    );
  }
}
