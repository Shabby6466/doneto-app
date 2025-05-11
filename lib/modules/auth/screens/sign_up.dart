import 'package:doneto/core/di/di.dart';
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

class SignUpIndex extends StatefulWidget {
  const SignUpIndex({super.key});

  @override
  State<SignUpIndex> createState() => _SignUpIndexState();
}

class _SignUpIndexState extends State<SignUpIndex> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is GoogleLoginSuccessState && state is! LoginBeforeFundraiserState) {
          sl<Navigation>().go(Routes.bottomTab);
        }
        if (state is GoogleLoginSuccessState && state is LoginBeforeFundraiserState) {
          sl<Navigation>().go(Routes.fundraisingIndex);
        }
        if (state is GoogleLoginFailedState) {
          Utility.showError(context, state.errMsg);
        }
        if (state is EmailVerificationRequiredState) {
          Utility.showSuccess(context, state.errMsg);
        }
        if (state is EmailVerificationFailedState) {
          Utility.showError(context, state.errMsg);
        }
        if (state is EmailVerifiedState) {
          sl<Navigation>().go(Routes.bottomTab);
        }
        if (state is SignUpWithEmailFailedState) {
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
                    context.read<AuthBloc>().add(ClearAuthStateEvent());
                  }
                },
                title: '',
              ),
              if (state is EmailVerificationRequiredState || state is EmailVerificationFailedState || state is EmailVerificationLoadingState) ...[
                // verification section
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    textAlign: TextAlign.center,
                    state.errMsg,
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(color: R.palette.primary, fontSize: 26.72.sp, fontWeight: FontWeight.w800, height: 1.h),
                  ),
                ),
                SizedBox(height: 41.h),
                MyCustomButton(
                  onTap: () {
                    context.read<AuthBloc>().add(CheckEmailVerifiedEvent());
                  },
                  title: 'Verified Email',
                  //
                ),
                const Spacer(),
                //
              ] else ...[
                // sign up section
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
                  child: MaterialTextFormField(
                    controller: _nameController,
                    labelText: 'Name',
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
                  child: MaterialTextFormField(
                    controller: _confirmPasswordController,
                    labelText: 'Confirm Password',
                    errorText: '',
                    onChange: (e) {},
                    //
                  ),
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
                SizedBox(height: 25.h),
                MyCustomButton(
                  onTap: () {
                    context.read<AuthBloc>().add(
                      SignUpWithEmailEvent(
                        email: _emailController.text,
                        password: _passwordController.text,
                        confirmPassword: _confirmPasswordController.text,
                        //
                      ),
                    );
                  },
                  title: 'sign up',
                  //
                ),

                ///
              ],
              SizedBox(height: 26.h),
              Text(
                'or sign up with',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
              ),
              SizedBox(height: 23.h),
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
                  SizedBox(width: 3.w),

                  GestureDetector(
                    onTap: () {
                      if (sl<Navigation>().canPop()) {
                        sl<Navigation>().popFromRoute();
                      }
                    },
                    child: Text(
                      'SIGN IN',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: R.palette.primary, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 60.h),
            ],
          ),
        );
      },
    );
  }
}
