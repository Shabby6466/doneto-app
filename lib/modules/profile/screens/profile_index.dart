import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/utils/utitily_methods/utils.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../fundraiser/widgets/doneto_button.dart';

class ProfileIndex extends StatefulWidget {
  const ProfileIndex({super.key});

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is LogoutSuccessState) {
          sl<Navigation>().go(Routes.auth);
        }
        if (state is LogoutFailedState) {
          Utility.showError(context, state.errMsg);
        }
      },
      builder: (context, state) {
        return Background(
          safeAreaTop: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Spacer(),
                      Image.asset(
                        R.assets.graphics.pngIcons.donetoLogo,
                        width: 182.w,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthBloc>().add(LogoutEvent());
                        },
                        child: SvgPicture.asset(
                          R.assets.graphics.svgIcons.redCross,
                          width: 35.h,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.95.h),
                Container(
                  height: 150.h,
                  width: 150.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(R.assets.graphics.pngIcons.bgFlowers),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Faraz Asad',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w800,
                      color: R.palette.blackColor,
                      height: 1.5.h,
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 318.w,
                    alignment: Alignment.center,
                    child: Text(
                      'Passionate about crisis relif \nhelp the victms of society everyone \ndeserves ,happiness',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: R.palette.blackColor,
                        height: 1.4.h,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 31.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '127 profile views',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: R.palette.blackColor,
                      height: 1.4.h,
                    ),
                  ),
                ),
                SizedBox(height: 43.h),
                Padding(
                  padding: const EdgeInsets.only(right: 113, left: 115),
                  child: DonetoButton(
                    title: 'Share Profile',
                    onTap: () {
                      sl<Navigation>().push(path: Routes.fundraisingIndex);
                    },
                  ),
                ),
                SizedBox(height: 28.h),
                Text(
                  'Fundraisers I support',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: R.palette.blackColor,
                    height: 1.4.h,
                  ),
                ),
                SizedBox(height: 24.h),

                /// Horizontal Scrollable List of Fundraisers
                SizedBox(
                  height: 100.h,
                  child: ListView.separated(
                    separatorBuilder:
                        (context, index) => SizedBox(height: 15.h),
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 12.w),
                        child: Container(
                          height: 78.h,
                          width: 354.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: R.palette.secondary2,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.r),
                                  bottomLeft: Radius.circular(20.r),
                                ),
                                child: Image.asset(
                                  R.assets.graphics.pngIcons.bgFlowers,
                                  height: 78.h,
                                  width: 78.h,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '54 supporters',
                                        style:
                                            Theme.of(
                                              context,
                                            ).textTheme.bodySmall,
                                      ),
                                      Text(
                                        'Help Fizza go to school',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.labelMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      const LinearProgressIndicator(
                                        minHeight: 8,
                                        value: 0.75,
                                        backgroundColor: Color(0xFFE0E0E0),
                                        valueColor: AlwaysStoppedAnimation(
                                          Color(0xFF4CAF50),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 25.h),

                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Show more',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: R.palette.primary,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 41.h),
                Text(
                  'social links',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: R.palette.blackColor,
                    height: 1.4.h,
                  ),
                ),
                SizedBox(height: 25.h),
                Text(
                  'Instagram',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    color: R.palette.blackColor,
                    height: 1.4.h,
                  ),
                ),
                SizedBox(height: 59.h),
                Container(
                  padding:  EdgeInsets.only(top:17,left: 14.w, right: 97.w),
                  height: 112.h,
                  width: 326.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: R.palette.skin,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(
                            context,
                          ).textTheme.labelSmall!.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: R.palette.blackColor,
                            height: 1.2.h,
                          ), // inherit default text style
                          children: [
                            TextSpan(
                              text: 'share your profile',
                              style: TextStyle(color: R.palette.primary),
                            ),

                            const TextSpan(
                              text: ' to inspire people to help',
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height:21.h),
                      Row(
                        children: [
                          
                          const Text('share profile '),
                          SvgPicture.asset(R.assets.graphics.svgIcons.nextArrow,colorFilter:const ColorFilter.mode(Colors.black, BlendMode.srcATop),width:10.w,height:5.h),
                        ],
                      ),
                    ],

                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
