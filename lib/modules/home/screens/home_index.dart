import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button.dart';
import 'package:doneto/modules/home/widgets/donation_cards_grid.dart';
import 'package:doneto/modules/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({super.key});

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  @override
  Widget build(BuildContext context) {
    return Background(
      safeAreaTop: true,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),
            Center(
              child: Image.asset(
                R.assets.graphics.pngIcons.donetoLogo,
                width: 182.w,
                //
              ),
            ),
            const CustomSearchBar(),
            SizedBox(height: 34.h),
            Padding(
              padding: EdgeInsets.only(left:18.w ,right: 18.w),
              child: Text(
                'Fundraise for the people and causes you care about',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  color: R.palette.blackColor,
                  height: 1.5.h,
                  //
                ),
              ),
            ),
            SizedBox(height: 18.h),
            Padding(
              padding: EdgeInsets.only(left: 18.w, right: 190.w),
              child: DonetoButton(
                title: 'Start a fundraiser',
                onTap: () {
                  sl<Navigation>().push(path: Routes.fundraisingIndex);
                },
                //
              ),
              //
            ),
            SizedBox(height: 31.h),
            Padding(padding: EdgeInsets.symmetric(horizontal: 23.w), child: Divider(color: R.palette.gray)),
            const DonationCardsGrid(),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
