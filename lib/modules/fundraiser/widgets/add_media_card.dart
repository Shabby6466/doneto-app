import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AddMediaCard extends StatelessWidget {
  /// Called when the user taps the card
  final VoidCallback? onTap;

  /// Text shown in the bottom-right
  final String label;

  /// Border radius
  final double borderRadius;

  /// Dash pattern: [dashLength, gapLength]
  final List<double> dashPattern;

  /// Height of the card
  final double height;

  const AddMediaCard({
    super.key,
    this.onTap,
    this.label = 'Add photo or video',
    this.borderRadius = 6,
    this.dashPattern = const [10, 5],

    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 18.w, right: 18.w),
      child: DottedBorder(
        borderType: BorderType.RRect,
        color: R.palette.gray,
        dashPattern: dashPattern,
        radius: Radius.circular(borderRadius),
        strokeWidth: 1.5,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            height: height,
            width: double.infinity,
            alignment: Alignment.center,
            child: Stack(
              children: [SvgPicture.asset(R.assets.graphics.svgIcons.cameraIcon, colorFilter: ColorFilter.mode(R.palette.primary, BlendMode.srcIn))],
            ),
          ),
        ),
      ),
    );
  }
}
