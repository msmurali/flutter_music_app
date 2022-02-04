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

  final bool _snapable = true;

  final double _maxSizeFactor = 1.0;

  final double _collapsedHeight = 88;

  double _calculateOpacity(BuildContext context, ScrollController controller) {
    late double _viewPortDimension;
    double _screenHeight = MediaQuery.of(context).size.height;

    try {
      _viewPortDimension = controller.position.viewportDimension;
    } catch (exception) {
      _viewPortDimension = _collapsedHeight;
    }

    double _percentage = (_viewPortDimension - _collapsedHeight) /
        (_screenHeight - _collapsedHeight);

    if (_percentage < 0.2) {
      _expanded = false;
      return 0;
    } else if (_percentage > 0.8) {
      _expanded = true;
      return 1;
    } else {
      return _percentage;
    }
  }

  Widget _buildAnimatedOpacityWidget({
    required BuildContext context,
    required ScrollController controller,
    required double initialOpacity,
    required Widget child,
  }) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? widget) {
        double _opacity = initialOpacity;
        if (controller.hasClients) {
          _opacity = _calculateOpacity(context, controller);
        }
        return Opacity(
          opacity: (initialOpacity - _opacity).abs(),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double _screenHeight = MediaQuery.of(context).size.height;

    return DraggableScrollableActuator(
      child: DraggableScrollableSheet(
        initialChildSize: _collapsedHeight / _screenHeight,
        minChildSize: _collapsedHeight / _screenHeight,
        maxChildSize: _maxSizeFactor,
        snap: _snapable,
        builder: (BuildContext context, ScrollController scrollController) {
          return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (OverscrollIndicatorNotification notification) {
              notification.disallowIndicator();
              return true;
            },
            child: WillPopScope(
              onWillPop: () async {
                if (_expanded) {
                  DraggableScrollableActuator.reset(context);
                  return false;
                } else {
                  return true;
                }
              },
              child: SingleChildScrollView(
                controller: scrollController,
                child: Stack(
                  children: [
                    _buildAnimatedOpacityWidget(
                      child: widget.collapsed,
                      controller: scrollController,
                      context: context,
                      initialOpacity: 1,
                    ),
                    _buildAnimatedOpacityWidget(
                      child: widget.expanded,
                      controller: scrollController,
                      context: context,
                      initialOpacity: 0,
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
