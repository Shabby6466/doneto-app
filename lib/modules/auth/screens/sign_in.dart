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
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/di/di.dart';

class SignInIndex extends StatefulWidget {
  const SignInIndex({super.key});

  @override
  State<SignInIndex> createState() => _SignInIndexState();
}

class _SignInIndexState extends State<SignInIndex> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(ClearAuthStateEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is GoogleLoginSuccessState && state is! LoginBeforeFundraiserState) {
          sl<Navigation>().go(Routes.bottomTab);
        }
        if (state is GoogleLoginFailedState) {
          Utility.showError(context, state.errMsg);
        }
        if (state is SignInWithEmailSuccessState && state is! LoginBeforeFundraiserState) {
          sl<Navigation>().go(Routes.bottomTab);
        }
        if (state is GoogleLoginSuccessState && state is LoginBeforeFundraiserState) {
          sl<Navigation>().go(Routes.fundraisingIndex);
        }
        if (state is SignInWithEmailSuccessState && state is LoginBeforeFundraiserState) {
          sl<Navigation>().go(Routes.fundraisingIndex);
        }
        if (state is SignInWitheEmailFailedState) {
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
                child: MaterialTextFormField(
                  controller: _emailController,
                  labelText: 'Email',
                  errorText: '',
                  onChange: (e) {},
                  //
                ),
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
                child: MaterialTextFormField(
                  controller: _passwordController,
                  labelText: 'Password',
                  errorText: '',
                  onChange: (e) {},
                  //
                ),
              ),
              SizedBox(height: 37.h),
              MyCustomButton(
                onTap: () {
                  context.read<AuthBloc>().add(
                    SignInWithEmailEvent(
                      email: _emailController.text,
                      password: _passwordController.text,
                      //
                    ),
                  );
                },
                title: 'sign in',
              ),
              SizedBox(height: 26.h),
              Text(
                'or sign in with',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
              ),
              SizedBox(height: 38.16.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w),
                child: GestureDetector(
                  onTap: () {
                    context.read<AuthBloc>().add(SignInUsingGoogleEvent());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                    height: 50.h,
                    decoration: BoxDecoration(color: R.palette.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(16.r)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(R.assets.graphics.svgIcons.googleLogo),
                        SizedBox(width: 15.w),
                        Text(
                          'Sign In With Google',
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 15.sp, height: 1.3.h, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ),
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
