import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundraiserStep3 extends StatefulWidget {
  const FundraiserStep3({super.key});

  @override
  State<FundraiserStep3> createState() => _FundraiserStep3State();
}

class _FundraiserStep3State extends State<FundraiserStep3> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Background(
        safeAreaTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget('Almost done. Add a fundraiser photo', size: 30.sp, height: 1.h, weight: FontWeight.w800, color: R.palette.primary),
            SizedBox(height: 22.h),
            TextWidget(
              'A high-quality photo or video will help tell your story and build trust with donors',
              size: 16.sp,
              height: 1.h,
              weight: FontWeight.w500,
              color: R.palette.blackColor,
            ),
          ],
        ),
      ),
    );
  }
}
