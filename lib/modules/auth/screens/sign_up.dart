import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/custom_textfield.dart';
import 'package:doneto/core/widgets/my_button.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpIndex extends StatefulWidget {
  const SignUpIndex({super.key});

  @override
  State<SignUpIndex> createState() => _SignUpIndexState();
}

class _SignUpIndexState extends State<SignUpIndex> {
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
            title: '',
          ),
          SizedBox(height: 45.h),
          Text(
            'Create your account',
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(color: R.palette.primary, fontSize: 26.72.sp, fontWeight: FontWeight.w800, height: 1.h),
          ),
          SizedBox(height: 41.h),
          Padding(
            padding: EdgeInsets.only(left: 51.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Name',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
              ),
            ),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 51.w, right: 63.w),
            child: MaterialTextFormField(labelText: 'Name', errorText: '', onChange: (e) {}),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 51.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Email',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
              ),
            ),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 51.w, right: 63.w),
            child: MaterialTextFormField(labelText: 'Email', errorText: '', onChange: (e) {}),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 51.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Password',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
              ),
            ),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 51.w, right: 63.w),
            child: MaterialTextFormField(labelText: 'Password', errorText: '', onChange: (e) {}),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 51.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Confirm Password',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
              ),
            ),
          ),
          SizedBox(height: 13.h),
          Padding(
            padding: EdgeInsets.only(left: 51.w, right: 63.w),
            child: MaterialTextFormField(labelText: 'Confirm Password', errorText: '', onChange: (e) {}),
          ),
          SizedBox(height: 18.h),
          Padding(
            padding: EdgeInsets.only(left: 64.w),
            child: Row(
              children: [
                Text(
                  'I understood the',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 12.sp, fontWeight: FontWeight.w400, height: 1.h),
                ),
                SizedBox(width: 4.5.w),

                Text(
                  'terms and policy.',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: R.palette.primary, fontSize: 12.sp, fontWeight: FontWeight.w400, height: 1.h),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          MyCustomButton(onTap: () {}, title: 'sign up'),
          SizedBox(height: 26.h),
          Text(
            'or sign up with',
            style: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
          ),
          SizedBox(height: 23.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyIconButton(onTap: () {}, image: R.assets.graphics.svgIcons.googleLogo),
              MyIconButton(onTap: () {}, image: R.assets.graphics.svgIcons.facebookLogo),
              MyIconButton(onTap: () {}, image: R.assets.graphics.svgIcons.googleLogo),
            ],
          ),
          SizedBox(height: 26.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
              ),
              SizedBox(width: 3.w,),

              Text(
                'SIGN IN',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.primary, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
