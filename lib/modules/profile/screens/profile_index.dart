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
                    Image.asset(width: 182.w, R.assets.graphics.pngIcons.donetoLogo),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(LogoutEvent());
                      },
                      child: SvgPicture.asset(width: 35.h, R.assets.graphics.svgIcons.redCross),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
