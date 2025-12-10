import 'package:flutter/material.dart';

class DottedDivider extends StatelessWidget {
  final double height;
  final double thickness;
  final Color color;
  final double dashWidth;
  final double dashSpace;

  const DottedDivider({
    super.key,
    this.height = 1,
    this.thickness = 1,
    this.color = Colors.grey,
    this.dashWidth = 5,
    this.dashSpace = 3,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: thickness,
              child: DecoratedBox(decoration: BoxDecoration(color: color)),
            );
          }),
        );
      },
    );
  }
}
