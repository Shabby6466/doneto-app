import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/text_widget.dart';
import 'package:doneto/modules/fundraiser/widgets/add_media_card.dart';
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
      padding: EdgeInsets.only(left: 20.w, right: 25.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Almost done. Add a fundraiser photo',
            style: Theme.of(
              context,
            ).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 30.sp, fontWeight: FontWeight.w700, fontFamily: 'Poppins',height: 1.3.h),
          ),
          SizedBox(height: 22.h),
          TextWidget(
            'A high-quality photo or video will help tell your story and build trust with donors',
            size: 16.sp,
            height: 1.3.h,
            weight: FontWeight.w500,
            color: R.palette.blackColor,
          ),
          SizedBox(height: 46.h),
          const AddMediaCard(),
        ],
      ),
    );
  }
}
