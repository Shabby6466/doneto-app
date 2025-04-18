import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyCustomButton extends StatefulWidget {
  final GestureTapCallback onTap;
  final String title;
  final Color? color;

  const MyCustomButton({super.key, required this.onTap, required this.title, this.color});

  @override
  State<MyCustomButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyCustomButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 48.h,
        width: 294.w,
        decoration: BoxDecoration(
          color: widget.color ?? R.palette.primary,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: R.palette.primary),
        ),
        child: Center(
          child: Text(
            widget.title,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1.h,
              color: widget.color == R.palette.white ? R.palette.primary : R.palette.white,
            ),
          ),
        ),
      ),
    );
  }
}

class MyIconButton extends StatelessWidget {
  final GestureTapCallback onTap;
  final String image;
  final Color? color;

  const MyIconButton({super.key, required this.onTap, required this.image, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54.h,
        width: 86.w,
        decoration: BoxDecoration(color: color ?? R.palette.white, shape: BoxShape.circle),
        child: Padding(
          padding: EdgeInsets.only(left: 33.w, right: 33.w, top: 11.h, bottom: 10.6.h),
          child: Center(child: SvgPicture.asset(image)),
        ),
      ),
    );
  }
}
