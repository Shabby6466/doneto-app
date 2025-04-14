import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthIndex extends StatefulWidget {
  const AuthIndex({super.key});

  @override
  State<AuthIndex> createState() => _AuthIndexState();
}

class _AuthIndexState extends State<AuthIndex> {
  @override
  Widget build(BuildContext context) {
    return Background(
      safeAreaTop: true,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 121.h),
            Center(
              child: Image.asset(
                height: 94.h,
                width: 228.w,
                R.assets.graphics.pngIcons.donetoLogo,
              ),
            ),
            SizedBox(height: 37.h),
            TextWidget(
              'Sign in your account',
              size: 26.72.sp,
              weight: FontWeight.w600,
              height: 11.58.sp / 26.72.sp,
            ),
          ],
        ),
      ),
    );
  }
}
