import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/widgets/underline_text_field.dart';
import 'package:doneto/modules/fundraiser/widgets/donation_disclaimer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstFundraiserDetail extends StatefulWidget {
  const FirstFundraiserDetail({super.key});

  @override
  State<FirstFundraiserDetail> createState() => _FirstFundraiserDetailState();
}

class _FirstFundraiserDetailState extends State<FirstFundraiserDetail> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Fundraiser Details',
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 30.sp, fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
            ),
            SizedBox(height: 22.h),
            Text(
              'How much would you like to raise?',
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
            ),
            SizedBox(height: 11.h),
            UnderlineTextField(hintText: 'Enter amount', suffixText: 'PKR', controller: _amountController),
            SizedBox(height: 35.h),
            Text(
              'What kind of fundraiser are you creating?',
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
            ),
            SizedBox(height: 11.h),
            UnderlineTextField(hintText: 'Select a category', suffixText: '', controller: _categoryController),
            SizedBox(height: 35.h),
            Text(
              'Where are you fundraising from?',
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
            ),
            SizedBox(height: 11.h),
            UnderlineTextField(hintText: 'Search your ZIP code', suffixText: '', controller: _categoryController),
            SizedBox(height: 20.h),
            Row(
              spacing: 3.51.w,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(R.assets.graphics.svgIcons.gpsIcon),
                Text(
                  'use current location',
                  style: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            DonationDisclaimer(onPrivacyPolicyTap: () {}, onTermsTap: () {}),
          ],
        ),
      ),
    );
  }
}
