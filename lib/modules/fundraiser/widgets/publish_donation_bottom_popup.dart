import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/auth/bloc/auth_bloc.dart';
import 'package:doneto/modules/fundraiser/bloc/fundraiser_bloc.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DonationPopupSheet extends StatelessWidget {
  final ScrollController scrollCam;
  final PanelController controller;

  const DonationPopupSheet({super.key, required this.scrollCam, required this.controller});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {}),
        BlocListener<FundraiserBloc, FundraiserState>(
          listener: (context, fundraiserState) {
            if (fundraiserState is FundraiserDraftSuccessState) {
              sl<Navigation>().go(Routes.fundraiserPublishResponse);
            }
          },
        ),
      ],
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 14.h),
            child: Column(
              children: [
                Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
                SizedBox(height: 8.h),
                Image.asset(R.assets.graphics.pngIcons.img, width: 100.w),
                SizedBox(height: 8.h),
                Text(
                  'Every Rupee Counts',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 11.sp, color: R.palette.primary, fontWeight: FontWeight.w200),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return DonetoButton(
                  loading: state.loading,
                  title: 'Publish',
                  onTap: () {
                    if (state is TokenFoundState) {
                      context.read<FundraiserBloc>().add(CreateFundraiserDraftEvent());
                    }
                    if (state is TokenNotFoundState) {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        //
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                          //
                        ),
                        builder: (_) => _loginFirst(context),
                      );
                    }

                    // sl<Navigation>().go(Routes.fundraiserPublishResponse);
                  },
                );
              },
            ),
          ),
          SizedBox(height: 30.h),
        ],
      ),

      //
    );
  }
}

Widget _loginFirst(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 20.h),
    height: 220.h,
    width: 400.w,
    decoration: BoxDecoration(
      color: R.palette.white,
      borderRadius: BorderRadius.circular(16.r),
      //
    ),
    child: Column(
      children: [
        Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
        SizedBox(height: 8.h),
        Image.asset(R.assets.graphics.pngIcons.img, width: 100.w),
        SizedBox(height: 8.h),
        Text(
          'Login First to Publish Fundraiser',
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 20.sp,
            //
          ),
        ),
        SizedBox(height: 30.h),
        DonetoButton(
          title: 'Login',
          onTap: () {
            context.read<AuthBloc>().add(LoginBeforeFundraiserEvent());
            sl<Navigation>().push(path: Routes.signIn);
          },
        ),
      ],
    ),
  );
}
