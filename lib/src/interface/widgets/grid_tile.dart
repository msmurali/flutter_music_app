import 'package:flutter/material.dart';

class GridTile extends StatelessWidget {
  final Widget artwork;
  final void Function()? onTap;
  final void Function(LongPressStartDetails)? onLongPress;
  final String title;
  final int gridSize;
  final dynamic entity;

  const GridTile({
    Key? key,
    required this.artwork,
    required this.onTap,
    required this.onLongPress,
    required this.title,
    required this.gridSize,
    required this.entity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onLongPressStart: onLongPress,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.transparent,
            width: 1.4,
          ),
          borderRadius: BorderRadius.circular(
              (gridSize == 2 || gridSize == 3) ? 8.0 : 4.0),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: artwork,
            ),
            (gridSize == 2 || gridSize == 3)
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black45,
                            Colors.transparent,
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(8.0),
                          bottomRight: Radius.circular(8.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          title,
                          style: theme.textTheme.bodyText2,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
