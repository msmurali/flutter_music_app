import 'package:flutter/material.dart';

class ToastWidget extends StatelessWidget {
  final String text;
  const ToastWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4.0,
        horizontal: 8.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Colors.grey[350],
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodyText2!.copyWith(
              color: Colors.black,
            ),
      ),
    );
  }
}
