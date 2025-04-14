import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/services/l10n/gen_l10n/app_localizations.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashIndex extends StatefulWidget {
  const SplashIndex({super.key});

  @override
  State<SplashIndex> createState() => _SplashIndexState();
}

class _SplashIndexState extends State<SplashIndex> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
    ).then((_) => sl<Navigation>().go(Routes.auth));
  }

  @override
  Widget build(BuildContext context) {
    var tr = AppLocalizations.of(context);
    return Background(
      bgColor: R.palette.primary,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 35.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Fundraising made simple',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  fontSize: 25.sp,
                  color: R.palette.white,
                  height: 1.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Align(
              alignment: Alignment.bottomRight,
              child: Row(
                children: [
                  Expanded(child: Divider(color: R.palette.gray)),
                  SizedBox(width: 20.w),
                  Text(
                    'with Doneto',
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 18.sp,
                      color: R.palette.white.withValues(alpha: 1),
                      height: 1.sp,
                      fontWeight: FontWeight.w200,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
