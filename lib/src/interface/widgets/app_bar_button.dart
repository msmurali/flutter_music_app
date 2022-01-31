import 'package:flutter/material.dart';
import 'package:music/src/interface/widgets/circular_icon_button.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16.0),
      child: CircularIconButton(
        child: const Padding(
          padding: EdgeInsets.only(left: 6.0),
          child: Icon(Icons.arrow_back_ios),
        ),
        radius: 20.0,
        onPressed: () {
          Navigator.pop(context);
        },
        iconSize: 16.0,
        toolTip: 'Back',
      ),
    );
  }
}
