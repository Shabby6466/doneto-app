import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class CasheroDivider extends StatelessWidget {
  final double? height;
  final bool? hasIntend;
  final double? thickness;
  const CasheroDivider({super.key, this.height, this.hasIntend = true, this.thickness});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: height ?? 0,
      thickness: thickness ??1.h,
      indent: hasIntend! ? 16.w : 0,
      endIndent: hasIntend! ? 16.w : 0,
      color: Theme.of(context).dividerColor
    );
  }
}
