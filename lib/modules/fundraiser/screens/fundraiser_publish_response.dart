import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button_white.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundraiserPublishResponse extends StatefulWidget {
  const FundraiserPublishResponse({super.key});

  @override
  State<FundraiserPublishResponse> createState() => _FundraiserPublishResponseState();
}

class _FundraiserPublishResponseState extends State<FundraiserPublishResponse> {
  @override
  Widget build(BuildContext context) {
    return Background(
      bgColor: R.palette.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(
            child: Text(
              textAlign: TextAlign.center,
              'Your Fundraiser is ready to share.',
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(color: R.palette.white, fontSize: 36.sp, fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
            ),
          ),
          const Spacer(),
          Padding(padding: EdgeInsets.symmetric(horizontal: 54.w), child: const DonetoButtonWhite(title: 'Share fundraiser')),
          SizedBox(height: 16.h),
          GestureDetector(
            onTap: (){
              sl<Navigation>().go(Routes.bottomTab);
            },
            child: Text(
              'Skip',
              style: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(color: R.palette.white, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
            ),
          ),
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
