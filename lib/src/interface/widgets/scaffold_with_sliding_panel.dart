import 'package:flutter/material.dart';

class ScaffoldWithSlidingPanel extends StatelessWidget {
  final Widget body;
  final Widget collapsed;
  final Widget expanded;

  const ScaffoldWithSlidingPanel({
    Key? key,
    required this.body,
    required this.collapsed,
    required this.expanded,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        body,
        AnimatedSheet(
          collapsed: collapsed,
          expanded: expanded,
        ),
      ],
    );
  }
}

class AnimatedSheet extends StatefulWidget {
  final Widget collapsed;
  final Widget expanded;

  const AnimatedSheet(
      {Key? key, required this.collapsed, required this.expanded})
      : super(key: key);

  @override
  State<AnimatedSheet> createState() => _AnimatedSheetState();
}

class _AnimatedSheetState extends State<AnimatedSheet> {
  bool _expanded = false;

  final DraggableScrollableController _dsController =
      DraggableScrollableController();

  final bool _snapable = true;

  final double _maxChildSize = 1.0;

  final double _collapsedHeight = 88;

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;
    final double _minChildSize = _collapsedHeight / _screenHeight;

    return DraggableScrollableActuator(
      child: DraggableScrollableSheet(
        initialChildSize: _minChildSize,
        minChildSize: _minChildSize,
        maxChildSize: _maxChildSize,
        snap: _snapable,
        controller: _dsController,
        builder: (BuildContext context, ScrollController scrollController) {
          return WillPopScope(
            onWillPop: () async {
              if (_expanded) {
                _dsController.animateTo(_minChildSize,
                    duration: const Duration(
                      milliseconds: 200,
                    ),
                    curve: Curves.easeInOut);
                _dsController.reset();
                return false;
              } else {
                return true;
              }
            },
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (notification) {
                notification.disallowIndicator();
                return true;
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  children: [
                    widget.collapsed,
                    AnimatedBuilder(
                      animation: scrollController,
                      builder: (BuildContext context, Widget? child) {
                        if (_dsController.size > 0.8) {
                          _expanded = true;
                        } else {
                          _expanded = false;
                        }

                        double _opacity = (_dsController.size - _minChildSize) /
                            (_maxChildSize - _minChildSize);

                        return IgnorePointer(
                          ignoring: !_expanded,
                          child: Opacity(
                            opacity: _opacity.clamp(0.0, 1.0).toDouble(),
                            child: widget.expanded,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
