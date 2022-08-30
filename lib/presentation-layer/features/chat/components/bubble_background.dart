import 'package:flutter/material.dart';

import 'bubble_painter.dart';

@immutable
class BubbleBackground extends StatelessWidget {
  const BubbleBackground({
    Key? key,
    required this.colors,
    this.child,
  }) : super(key: key);

  final List<Color> colors;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BubblePainter(
          colors: colors,
          bubbleContext: context,
          scrollable: Scrollable.of(context)! //ScrollableState()
          ),
      child: child,
    );
  }
}
