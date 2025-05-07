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
                      width: 182.w,
                      R.assets.graphics.pngIcons.donetoLogo,
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                      },
                      child: SvgPicture.asset(
                        width: 35.h,
                        R.assets.graphics.svgIcons.redCross,
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
              SizedBox(height: 31),
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Fundraisers I support',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                    color: R.palette.blackColor,
                    height: 1.4.h,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
