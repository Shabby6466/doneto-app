import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doneto/core/utils/resource/r.dart';

class BackArrow extends StatelessWidget {
  final VoidCallback action;
  final Color? iconColor;

  const BackArrow({super.key, required this.action, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: Container(
        height: 40.h,
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 12.w),
        child: SvgPicture.asset(
          height: 16.h,
          width: 9.w,
          R.assets.graphics.svgIcons.sendIcon,
        ),
      ),
    );
  }
}
