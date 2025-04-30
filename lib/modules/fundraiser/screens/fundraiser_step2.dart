import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundraiserStep2 extends StatefulWidget {
  const FundraiserStep2({super.key});

  @override
  State<FundraiserStep2> createState() => _FundraiserStep2State();
}

class _FundraiserStep2State extends State<FundraiserStep2> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Background(
        safeAreaTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget('Describe why you’re fundraising', size: 30.sp, height: 1.h, weight: FontWeight.w800, color: R.palette.primary),
            SizedBox(height: 22.h),
            TextWidget('Give your fundraiser a title', size: 16.sp, height: 1.h, weight: FontWeight.w500, color: R.palette.blackColor),
          ],
        ),
      ),
    );
  }
}
