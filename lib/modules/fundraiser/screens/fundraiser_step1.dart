import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/custom_textfield.dart';
import 'package:doneto/core/widgets/text_widget.dart';
import 'package:doneto/modules/fundraiser/widgets/fees_notice.dart';
import 'package:doneto/modules/fundraiser/widgets/submit_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FundraiserStep1 extends StatefulWidget {
  const FundraiserStep1({super.key});

  @override
  State<FundraiserStep1> createState() => _FundraiserStep1State();
}

class _FundraiserStep1State extends State<FundraiserStep1> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Background(
        safeAreaTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextWidget('Fundraiser details', size: 30.sp, height: 1.h, weight: FontWeight.w800, color: R.palette.primary),
            SizedBox(height: 22.h),
            TextWidget('How much would you like to raise?', size: 16.sp, height: 1.h, weight: FontWeight.w500, color: R.palette.blackColor),
            SizedBox(height: 11.h),
            MyCustomTextFormField(
              hintText: 'Enter amount',
              suffixText: 'PKR',
              onChange: (e) {},
              keyboardType: TextInputType.number,
              controller: _amountController,
            ),
            SizedBox(height: 35.h),
            TextWidget('What kind of fundraiser are you creating?', size: 16.sp, height: 1.h, weight: FontWeight.w500, color: R.palette.blackColor),
            SizedBox(height: 11.h),
            MyCustomTextFormField(
              hintText: 'Select a category',
              onChange: (e) {},
              keyboardType: TextInputType.number,
              controller: _categoryController,
            ),
            SizedBox(height: 41.h),
            TextWidget('Where are you fundraising from?', size: 16.sp, height: 1.h, weight: FontWeight.w500, color: R.palette.blackColor),
            SizedBox(height: 11.h),
            MyCustomTextFormField(
              hintText: 'Enter your location',
              onChange: (e) {},
              keyboardType: TextInputType.number,
              controller: _zipCodeController,
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(R.assets.graphics.svgIcons.gpsIcon, height: 18.h, width: 16.w),
                SizedBox(width: 3.51.w),
                TextWidget('Use current address', size: 16.sp, weight: FontWeight.w500, color: R.palette.primary),
              ],
            ),
            SizedBox(height: 45.64.h),
            Center(child: SizedBox(width: 308.w, child: const FeesNotice())),
            SizedBox(height: 23.h),
            Center(child: SubmitBtn(onTap: () {})),
          ],
        ),
      ),
    );
  }
}
