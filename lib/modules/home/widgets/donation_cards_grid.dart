import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class DonationCardsGrid extends StatelessWidget {
  const DonationCardsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 22.h),
        Padding(
          padding: EdgeInsets.only(left: 30.w, right: 23.w),
          child: Row(
            children: [
              Text(
                'Islamabad, PK',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w800, height: 1.3.h, color: R.palette.blackColor),
              ),
              const Spacer(),
              SvgPicture.asset(R.assets.graphics.svgIcons.gpsIcon),
              SizedBox(width: 3.5.w),
              Text(
                '2678',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500, height: 1.2.h, color: R.palette.primary),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 12.h,
            childAspectRatio: 181 / 194,
            children: List.generate(4, (i) {
              return _buildDonationCard('Help fizza to go to a school', R.assets.graphics.pngIcons.img, '12 mins', '23,454', context);
            }),
          ),
        ),
      ],
    );
  }
}

Widget _buildDonationCard(String title, String image, String timeLeft, String donationAmount, BuildContext context) {
  return Stack(
    children: [
      Container(
        padding: EdgeInsets.only(left: 7.w, right: 17.w),
        height: 194.h,
        width: 181.w,
        color: R.palette.secondary2,
        child: Column(
          children: [
            const Spacer(),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                height: 1.3.h,
                color: R.palette.blackColor,
                //
              ),
            ),
            SizedBox(height: 17.h),
            Row(
              children: [
                Text(
                  '$donationAmount raised of 40,000',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3.h,
                    color: R.palette.blackColor,
                    //
                  ),
                ),
                SizedBox(width: 4.w),
                Text(
                  'PKR',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3.h,
                    color: R.palette.primary,
                    //
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                height: 8.h,
                child: const LinearProgressIndicator(
                  minHeight: 8,
                  value: 0.75,
                  backgroundColor: Color(0xFFE0E0E0),
                  valueColor: AlwaysStoppedAnimation(Color(0xFF4CAF50)),
                ),
              ),
            ),
            SizedBox(height: 4.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Last donation $timeLeft ago',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.3.h,
                  color: R.palette.blackColor,
                  //
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: 181.w,
        height: 84.h,
        decoration: BoxDecoration(
          color: R.palette.white,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r), topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r), topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
          child: Image.asset(R.assets.graphics.pngIcons.bgFlowers, fit: BoxFit.cover),
        ),
      ),
    ],
  );
}
