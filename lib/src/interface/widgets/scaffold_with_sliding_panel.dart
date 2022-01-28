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

class AnimatedSheet extends StatelessWidget {
  final Widget collapsed;
  final Widget expanded;

  const AnimatedSheet(
      {Key? key, required this.collapsed, required this.expanded})
      : super(key: key);

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
      return 0;
    } else if (_percentage > 0.8) {
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

    return DraggableScrollableSheet(
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
          child: SingleChildScrollView(
            controller: scrollController,
            child: Stack(
              children: [
                _buildAnimatedOpacityWidget(
                  child: collapsed,
                  controller: scrollController,
                  context: context,
                  initialOpacity: 1,
                ),
                _buildAnimatedOpacityWidget(
                  child: expanded,
                  controller: scrollController,
                  context: context,
                  initialOpacity: 0,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
