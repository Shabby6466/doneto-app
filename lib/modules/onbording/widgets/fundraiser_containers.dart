import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FundraiserContainers extends StatelessWidget {
  final String svgImage;
  final String title;

  const FundraiserContainers({super.key, required this.svgImage, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 14.h, bottom: 15.h, left: 17.w),
      width: 326.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: R.palette.white,
        boxShadow: [BoxShadow(color: R.palette.blackColor.withValues(alpha: 0.15), blurRadius: 10.r, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          SvgPicture.asset(svgImage),
          SizedBox(width: 16.w),
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500, height: 1.h, color: R.palette.blackColor),
          ),
        ],
      ),
    );
  }
}
