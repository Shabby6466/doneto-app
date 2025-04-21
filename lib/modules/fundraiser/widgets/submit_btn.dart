import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SubmitBtn extends StatelessWidget {
  final VoidCallback? onTap;

  const SubmitBtn({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 63.h,
        width: 63.w,
        decoration: BoxDecoration(color: R.palette.primary, shape: BoxShape.circle),
        alignment: Alignment.center,
        padding: EdgeInsets.all(16.w),
        child: SvgPicture.asset(R.assets.graphics.svgIcons.nextArrow, height: 24.h, width: 24.w),
      ),
    );
  }
}
