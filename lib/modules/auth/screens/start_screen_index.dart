import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/my_button.dart';
import 'package:doneto/core/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthIndex extends StatefulWidget {
  const AuthIndex({super.key});

  @override
  State<AuthIndex> createState() => _AuthIndexState();
}

class _AuthIndexState extends State<AuthIndex> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipPath(
                clipper: BottomWaveClipper(),
                child: SizedBox(width: 402.w, height: 368.h, child: Image.asset(R.assets.graphics.pngIcons.bgFlowers, fit: BoxFit.fill)),
              ),
              Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'Your safe space for support',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontSize: 32.sp, height: 1.h, fontWeight: FontWeight.w900, color: R.palette.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Image.asset(height: 75.05.h, width: 182.w, R.assets.graphics.pngIcons.donetoLogo),
          SizedBox(height: 60.95.h),
          MyCustomButton(
            onTap: () {
              sl<Navigation>().push(path: Routes.fundraisingIndex);
            },
            title: 'start a fundraiser',
          ),
          SizedBox(height: 19.h),
          MyCustomButton(
            onTap: () {
              sl<Navigation>().push(path: Routes.signIn);
            },
            color: R.palette.white,
            title: 'sign in',
          ),
          SizedBox(height: 28.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.w),
            child: Row(
              children: [
                Expanded(child: Divider(color: R.palette.gray)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.5.w),
                  child: TextWidget('or', size: 16.sp, weight: FontWeight.w500, color: R.palette.gray),
                ),
                Expanded(child: Divider(color: R.palette.gray)),
              ],
            ),
          ),
          SizedBox(height: 22.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextWidget('browse fundraisers', size: 16.sp, weight: FontWeight.w500, color: R.palette.primary),
              SizedBox(width: 3.w),
              Column(children: [SizedBox(height: 2.h), SvgPicture.asset(R.assets.graphics.svgIcons.greenArrow, height: 12.h, width: 1.w)]),
            ],
          ),
          SizedBox(height: 67.h),
          Padding(
            padding: EdgeInsets.only(left: 94.w, right: 95.w),
            child: TextWidget(
              'By creating an account, you agree to our Terms and Conditions and Privacy Policy.',
              size: 10.sp,
              weight: FontWeight.w600,
              color: R.palette.blackColor.withValues(alpha: 0.8),
              height: 1.5.h,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(size.width / 2, size.height - 65, size.width, size.height - 20);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
