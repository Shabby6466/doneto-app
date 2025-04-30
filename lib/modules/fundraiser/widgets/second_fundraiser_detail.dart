import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondFundraiserDetail extends StatefulWidget {
  const SecondFundraiserDetail({super.key});

  @override
  State<SecondFundraiserDetail> createState() => _SecondFundraiserDetailState();
}

class _SecondFundraiserDetailState extends State<SecondFundraiserDetail> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 25.w),
        child: Column(
          children: [
            Text(
              'Describe why you’re fundraising',
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 30.sp, fontWeight: FontWeight.w700, fontFamily: 'Poppins',height: 1.3.h),
            ),
            SizedBox(height: 22.h),
          ],
        ),
      ),
    );
  }
}
