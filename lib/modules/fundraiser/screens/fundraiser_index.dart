import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/screens/fundraiser_step1.dart';
import 'package:doneto/modules/fundraiser/screens/fundraiser_step2.dart';
import 'package:doneto/modules/fundraiser/screens/fundraiser_step3.dart';
import 'package:doneto/modules/onbording/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FundraiserIndex extends StatefulWidget {
  const FundraiserIndex({super.key});

  @override
  State<FundraiserIndex> createState() => _FundraiserIndexState();
}

class _FundraiserIndexState extends State<FundraiserIndex> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingBloc, OnboardingState>(
      listener: (context, state) {},
      builder: (context, state) {
        void nextPage(BuildContext context) {
          if (state.currentPage == 2) {
          } else {
            context.read<OnboardingBloc>().add(NextPageEvent());
          }
        }

        void backPress(BuildContext context) {
          if (state.currentPage == 0) {
            if (sl<Navigation>().canPop()) {
              sl<Navigation>().popFromRoute();
            }
          } else {
            context.read<OnboardingBloc>().add(BackPageEvent());
          }
        }

        return Background(
          safeAreaTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              GestureDetector(
                onTap: () {
                  backPress(context);
                },
                child: Padding(padding: EdgeInsets.only(left: 38.w), child: SvgPicture.asset(R.assets.graphics.svgIcons.backArrow)),
              ),
              SizedBox(height: 26.h),
              SizedBox(
                height: 10.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => SizedBox(width: 16.w, height: 10.h),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return Container(height: 10.h, width: 127.w, color: state.currentPage == index ? R.palette.green : R.palette.lightGrey);
                  },
                ),
              ),
              SizedBox(height: 11.h),
              Center(
                child: Text(
                  'Step ${state.currentPage + 1} of 3',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge!.copyWith(color: R.palette.gray, fontSize: 14.sp, fontWeight: FontWeight.w800, height: 14.h / 14.h),
                ),
              ),
              SizedBox(height: 22.h),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (value) {
                    context.read<OnboardingBloc>().add(UpdatePageEvent(page: value));
                  },
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: [const FundraiserStep1(), const FundraiserStep2(), const FundraiserStep3()],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
