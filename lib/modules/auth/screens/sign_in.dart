import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/utils/utitily_methods/utils.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/custom_textfield.dart';
import 'package:doneto/core/widgets/my_button.dart';
import 'package:doneto/modules/auth/bloc/auth_bloc.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/di/di.dart';

class SignInIndex extends StatefulWidget {
  const SignInIndex({super.key});

  @override
  State<SignInIndex> createState() => _SignInIndexState();
}

class _SignInIndexState extends State<SignInIndex> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is GoogleLoginSuccessState) {
          sl<Navigation>().go(Routes.bottomTab);
        }
        if (state is GoogleLoginFailedState) {
          Utility.showError(context, state.errMsg);
        }
      },
      builder: (context, state) {
        return Background(
          bgColor: R.palette.secondary,
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
              SizedBox(height: 58.h),
              Center(child: SizedBox(height: 94.h, width: 228.w, child: Image.asset(R.assets.graphics.pngIcons.donetoLogo, fit: BoxFit.contain))),
              SizedBox(height: 39.h),
              Text(
                'Sign in your account',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.blackColor, fontSize: 26.72.sp, fontWeight: FontWeight.w800, height: 1.h),
              ),
              SizedBox(height: 51.84.h),
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
              SizedBox(height: 37.h),
              MyCustomButton(onTap: () {}, title: 'sign in'),
              SizedBox(height: 26.h),
              Text(
                'or sign in with',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
              ),
              SizedBox(height: 38.16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyIconButton(
                    onTap: () {
                      context.read<AuthBloc>().add(SignInUsingGoogleEvent());
                    },
                    image: R.assets.graphics.svgIcons.googleLogo,
                  ),
                  MyIconButton(onTap: () {}, image: R.assets.graphics.svgIcons.facebookLogo),
                  MyIconButton(onTap: () {}, image: R.assets.graphics.svgIcons.googleLogo),
                ],
              ),
              SizedBox(height: 37.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account?',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
                  ),
                  SizedBox(width: 3.w),

                  GestureDetector(
                    onTap: () {
                      sl<Navigation>().push(path: Routes.signUp);
                    },
                    child: Text(
                      'SIGN UP',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: R.palette.primary, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
