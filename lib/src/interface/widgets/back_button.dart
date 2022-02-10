import 'package:flutter/material.dart';

import 'app_bar_button.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBarButton(
      child: const Padding(
        padding: EdgeInsets.only(
          left: 6.0,
        ),
        child: Icon(
          Icons.arrow_back_ios,
          size: 16.0,
        ),
      ),
      radius: 20.0,
      tooltip: 'Back',
      onPressed: () => Navigator.pop(context),
      margin: const EdgeInsets.only(left: 16.0),
    );
  }
}
