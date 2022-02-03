import 'dart:async';
import 'package:flutter/material.dart';
import 'package:music/src/global/constants/index.dart';

Future<Option?> showMenuDialog(BuildContext context, dynamic details) async {
  double dx = details.globalPosition.dx;
  double dy = details.globalPosition.dy;

  RelativeRect position = RelativeRect.fromLTRB(dx, dy, dx, dy);

  TextStyle _textStyle = Theme.of(context).textTheme.bodyText2!;

  return await showMenu<Option>(
    context: context,
    position: position,
    items: Option.values
        .map(
          (opt) => PopupMenuItem(
            child: Text(
              optionsText[opt]!,
              style: _textStyle,
            ),
            value: opt,
          ),
        )
        .toList(),
  );
}
