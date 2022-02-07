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
  // double _collapsedInitialOpacity = 1.0;
  // double _expandedInitialOpacity = 0.0;

  final bool _snapable = true;

  final double _maxChildSize = 1.0;

  final double _collapsedHeight = 88;

  // double _calculateOpacity(BuildContext context, ScrollController controller) {
  //   late double _viewPortDimension;
  //   double _screenHeight = MediaQuery.of(context).size.height;

  //   try {
  //     _viewPortDimension = controller.position.viewportDimension;
  //   } catch (exception) {
  //     _viewPortDimension = _collapsedHeight;
  //   }

  //   double _percentage = (_viewPortDimension - _collapsedHeight) /
  //       (_screenHeight - _collapsedHeight);

  //   if (_percentage < 0.2) {
  //     _expanded = false;
  //     return 0;
  //   } else if (_percentage > 0.8) {
  //     _expanded = true;
  //     return 1;
  //   } else {
  //     return _percentage;
  //   }
  // }

  // Widget _buildAnimatedOpacityWidget({
  //   required BuildContext context,
  //   required ScrollController controller,
  //   required double initialOpacity,
  //   required Widget child,
  // }) {
  //   return AnimatedBuilder(
  //     animation: controller,
  //     builder: (BuildContext context, Widget? widget) {
  //       double _opacity = initialOpacity;
  //       if (controller.hasClients) {
  //         _opacity = _calculateOpacity(context, controller);
  //       }
  //       return Opacity(
  //         opacity: (initialOpacity - _opacity).abs(),
  //         child: child,
  //       );
  //     },
  //   );
  // }

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
                        if (_dsController.size == 1.0) {
                          _expanded = true;
                        } else {
                          _expanded = false;
                        }

                        double _opacity = (_dsController.size - _minChildSize) /
                            (_maxChildSize - _minChildSize);

                        return Opacity(
                          opacity: _opacity.clamp(0.0, 1.0).toDouble(),
                          child: widget.expanded,
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

    // return DraggableScrollableActuator(
    //   child: DraggableScrollableSheet(
    //     initialChildSize: _collapsedHeight / _screenHeight,
    //     minChildSize: _collapsedHeight / _screenHeight,
    //     maxChildSize: _maxSizeFactor,
    //     snap: _snapable,
    //     builder: (BuildContext context, ScrollController scrollController) {
    //       return NotificationListener<OverscrollIndicatorNotification>(
    //         onNotification: (OverscrollIndicatorNotification notification) {
    //           notification.disallowIndicator();
    //           return true;
    //         },
    //         child: WillPopScope(
    //           onWillPop: () async {
    //             if (_expanded) {
    //               DraggableScrollableActuator.reset(context);
    //               return false;
    //             } else {
    //               return true;
    //             }
    //           },
    //           child: SingleChildScrollView(
    //             controller: scrollController,
    //             child: Stack(
    //               children: [
    //                 _buildAnimatedOpacityWidget(
    //                   child: widget.collapsed,
    //                   controller: scrollController,
    //                   context: context,
    //                   initialOpacity: 1,
    //                 ),
    //                 _buildAnimatedOpacityWidget(
    //                   child: widget.expanded,
    //                   controller: scrollController,
    //                   context: context,
    //                   initialOpacity: 0,
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
