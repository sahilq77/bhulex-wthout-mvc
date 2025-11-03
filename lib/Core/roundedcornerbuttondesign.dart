import 'package:flutter/material.dart';

class RoundedCornerButtonDesign extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child;
  final Color color;
  // final ButtonStyle? style;
  // final Gradient? gradient;
  final double thickness;

  const RoundedCornerButtonDesign({
    Key? key,
    required this.onPressed,
    required this.child,
    required this.color,
    // this.style,
    // this.gradient,
    this.thickness = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: color, borderRadius: BorderRadius.circular(50.0)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
          ),
          child: child,
        ),
      ),
    );
  }
}
