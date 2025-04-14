import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doneto/core/utils/resource/r.dart';

class CustomSearchWidget extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final Color? fillColor;
  final Color? hintTextColor;
  final String searchIcon;
  final bool? closeIcon;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? closeIconOnTap;

  const CustomSearchWidget({
    super.key,
    this.controller,
    this.hintText = 'Search',
    this.onTap,
    this.onChanged,
    this.fillColor,
    this.hintTextColor,
    required this.searchIcon,
    this.padding,
    this.closeIcon,
    this.closeIconOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.only(left: 20.w, top: 24.h, right: 20.w),
      child: TextField(
        controller: controller,
        onTap: onTap,
        onChanged: onChanged,
        decoration: InputDecoration(
          suffixIcon:  closeIcon ?? false
                  ? Visibility(
                      visible: controller?.text.isNotEmpty ?? false,
                      child: GestureDetector(
                        onTap: closeIconOnTap,
                        child: Padding(
                          padding: EdgeInsets.only(right: 18.w, top: 14.h, bottom: 14.h),
                          child: SvgPicture.asset(
                            R.assets.graphics.svgIcons.closeIcon,
                            height: 20.h,
                            width: 20.w,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox.shrink(),
          hintText: hintText,
          hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                height: 16.sp / 14.sp,
                color: hintTextColor ?? R.palette.disabledText,
              ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Transform.scale(
              scale: 0.7,
              child: SvgPicture.asset(
                searchIcon,
                height: 24.h,
                width: 24.w,
              ),
            ),
          ),
          filled: true,
          fillColor: fillColor ?? R.palette.scBtn,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
