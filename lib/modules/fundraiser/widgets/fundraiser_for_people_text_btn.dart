import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundraiserForPeopleTextBtn extends StatefulWidget {
  const FundraiserForPeopleTextBtn({super.key});

  @override
  State<FundraiserForPeopleTextBtn> createState() => _FundraiserForPeopleTextBtnState();
}

class _FundraiserForPeopleTextBtnState extends State<FundraiserForPeopleTextBtn> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w),
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
      ],
    );
  }
}
