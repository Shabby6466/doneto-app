import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';

class PagesBar extends StatefulWidget {
  /// How many segments should be “filled” (green).
  final int activeSegments;

  /// Total number of segments.
  final int totalSegments;

  /// Height of each bar.
  final double height;

  /// Spacing between bars.
  final double spacing;


  const PagesBar({
    super.key,
    this.activeSegments = 2,
    this.totalSegments = 3,
    this.height = 10,
    this.spacing = 10,
  });

  @override
  State<PagesBar> createState() => _PagesBarState();
}

class _PagesBarState extends State<PagesBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(widget.totalSegments, (index) {
        final isActive = index < widget.activeSegments;
        return Expanded(
          child: Container(
            height: widget.height,
            margin: EdgeInsets.only(
              left: index == 0 ? 0 : widget.spacing / 2,
              right: index == widget.totalSegments - 1 ? 0 : widget.spacing / 2,
            ),
            decoration: BoxDecoration(
              color: isActive ? R.palette.primary : R.palette.gray,
            ),
          ),
        );
      }),
    );
  }
}
