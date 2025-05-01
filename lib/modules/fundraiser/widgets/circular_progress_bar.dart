import 'package:flutter/material.dart';

class CircularPercentageIndicator extends StatelessWidget {
  /// Percentage to display, from 0 to 100.
  final double percentage;

  /// Diameter of the circle.
  final double size;

  /// Width of the ring stroke.
  final double strokeWidth;

  /// Color of the background ring.
  final Color backgroundColor;

  /// Color of the progress arc.
  final Color progressColor;

  /// Text style for the percentage label.
  final TextStyle? textStyle;

  const CircularPercentageIndicator({
    super.key,
    required this.percentage,
    this.size = 80,
    this.strokeWidth = 8,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.progressColor = const Color(0xFF4CAF50),
    this.textStyle,
  }) : assert(percentage >= 0 && percentage <= 100);

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
