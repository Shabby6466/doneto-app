import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendIndex extends StatefulWidget {
  const SendIndex({super.key});

  @override
  State<SendIndex> createState() => _SendIndexState();
}

class _SendIndexState extends State<SendIndex> {
  @override
  Widget build(BuildContext context) {
    return Background(
      safeAreaTop: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.h),
          Center(
            child: Image.asset(
              width: 182.w,
              R.assets.graphics.pngIcons.donetoLogo,
              //
            ),
          ),
          SizedBox(height: 80.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
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
            ),
          ),
        ],
      ),
    );
  }
}
