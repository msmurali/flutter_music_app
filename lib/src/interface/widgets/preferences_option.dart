import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreferencesOption extends StatelessWidget {
  final String? asset;
  final String title;
  final bool active;
  final bool? enabled;
  final void Function() onTap;

  const PreferencesOption({
    Key? key,
    this.asset,
    required this.active,
    required this.title,
    required this.onTap,
    this.enabled,
  }) : super(key: key);

  Column _buildAsset() {
    return Column(
      children: [
        SizedBox(
          height: 80.0,
          width: 80.0,
          child: SvgPicture.asset(
            asset!,
          ),
        ),
        const SizedBox(
          height: 5.0,
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: enabled == false ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: theme.colorScheme.secondary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: active ? Colors.pinkAccent.shade400 : Colors.transparent,
            width: 1.8,
          ),
        ),
        child: Column(
          children: [
            asset != null ? _buildAsset() : const SizedBox(),
            Text(
              title,
              style: theme.textTheme.subtitle1,
            ),
          ],
        ),
      ),
    );
  }
}
