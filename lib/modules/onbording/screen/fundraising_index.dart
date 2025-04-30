import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/onbording/widgets/fundraiser_containers.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FundraisingIndex extends StatefulWidget {
  const FundraisingIndex({super.key});

  @override
  State<FundraisingIndex> createState() => _FundraisingIndexState();
}

class _FundraisingIndexState extends State<FundraisingIndex> {
  @override
  Widget build(BuildContext context) {
    return Background(
      safeAreaTop: true,
      child: Column(
        children: [
          MyTopBar(
            onTap: () {
              if (sl<Navigation>().canPop()) {
                sl<Navigation>().popFromRoute();
              }
            },
            title: 'start a fundraiser',
          ),
          SizedBox(height: 48.h),
          SizedBox(
            width: 342.w,
            child: Text(
              'Who are you fundraising for?',
              style: Theme.of(
                context,
              ).textTheme.titleLarge!.copyWith(color: R.palette.primary, fontSize: 32.sp, fontWeight: FontWeight.w900, height: 1.h),
            ),
          ),
          SizedBox(height: 48.h),
          GestureDetector(
              onTap: () {
                sl<Navigation>().push(path: Routes.fundraisingDetails);
              },
              child: FundraiserContainers(svgImage: R.assets.graphics.svgIcons.yourselfIcon, title: 'yourself')),
          SizedBox(height: 40.h),
          FundraiserContainers(svgImage: R.assets.graphics.svgIcons.someoneElse, title: 'someone else'),
          SizedBox(height: 40.h),
          FundraiserContainers(svgImage: R.assets.graphics.svgIcons.charity, title: 'charity'),
        ],
      ),
    );
  }
}
