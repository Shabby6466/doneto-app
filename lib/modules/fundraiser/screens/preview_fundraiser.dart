import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/text_widget.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button_white.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreviewFundraiser extends StatefulWidget {
  const PreviewFundraiser({super.key});

  @override
  State<PreviewFundraiser> createState() => _PreviewFundraiserState();
}

class _PreviewFundraiserState extends State<PreviewFundraiser> {
  @override
  Widget build(BuildContext context) {
    return Background(
      safeAreaTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyTopBar(
            onTap: () {
              if (sl<Navigation>().canPop()) {
                sl<Navigation>().popFromRoute();
              }
            },
            title: 'preview fundraiser',
          ),
          SizedBox(height: 23.h),
          Container(
            height: 223.h,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Stack(
              children: [
                SizedBox(
                  height: 223.h,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    R.assets.graphics.pngIcons.bgFlowers,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    height: 38.h,
                    width: 38.w,
                    decoration: BoxDecoration(
                      color: R.palette.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        R.assets.graphics.svgIcons.heartIcon,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Row(
              children: [
                TextWidget(
                  'Support to provide clean\nwater to the unprivilleged',
                  size: 20.h,
                  height: 1.1.h,
                  weight: FontWeight.w700,
                ),
              ],
            ),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Row(
              children: [
                TextWidget(
                  'PKR 3,000,000 GOAL · 1.7k donations',
                  size: 15.sp,
                  weight: FontWeight.w300,
                  color: R.palette.lightGray,
                ),
              ],
            ),
          ),
          SizedBox(height: 17.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 18.w),
            child: const DonetoButton(title: "DONATE NOW"),
          ),
          SizedBox(height: 11.h),
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 18.w),
            child: const DonetoButtonWhite(title: "SHARE"),
          ),
          SizedBox(height: 22.h),
          Center(
            child: Text(
              'PKR 2,785,254 RAISED',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                color: R.palette.blackColor,
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          SizedBox(height: 15.h),
          Padding(
            padding: EdgeInsets.only(left: 23.w, right: 35.w),
            child: Row(
              children: [
                Container(
                  height: 49.h,
                  width: 49.w,
                  decoration: BoxDecoration(
                    color: R.palette.lightGrey2,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      R.assets.graphics.svgIcons.organizerGrey,
                      width: 24,
                      height: 24,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                SizedBox(
                  width: 283.w,
                  child: Text(
                    'bondh-e-shams is the organizer of the fundraiser.',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: R.palette.lightGrey,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 36.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            child: Divider(height: 1.h, color: R.palette.lightGrey),
          ),
          SizedBox(height: 17.h,),
          Center(
            child: Container(
              width: 154.w,
              padding: EdgeInsets.only(left: 11.w, top: 5.h, bottom: 4.h),
              decoration: BoxDecoration(
                color: R.palette.green3,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    R.assets.graphics.svgIcons.protected,
                    width: 15.w,
                    height: 15.h,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "donation protected",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      color: R.palette.primary,
                      height: 1.h,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
