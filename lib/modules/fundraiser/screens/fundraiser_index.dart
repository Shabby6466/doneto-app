import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/text_widget.dart';
import 'package:doneto/modules/fundraiser/bloc/fundraiser_bloc.dart';
import 'package:doneto/modules/fundraiser/widgets/fundraiser_step3.dart';
import 'package:doneto/modules/fundraiser/widgets/first_fundraiser_detail.dart';
import 'package:doneto/modules/fundraiser/widgets/pages_bar.dart';
import 'package:doneto/modules/fundraiser/widgets/second_fundraiser_detail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

class FundraiserIndex extends StatefulWidget {
  const FundraiserIndex({super.key});

  @override
  State<FundraiserIndex> createState() => _FundraiserIndexState();
}

class _FundraiserIndexState extends State<FundraiserIndex> {
  static const int pagesCount = 3;
  final PageController _pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FundraiserBloc, FundraiserState>(
      listener: (context, state) {
        _pageController.animateToPage(state.currentIndex, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      },
      builder: (context, state) {
        return Background(
          safeAreaTop: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              GestureDetector(
                onTap: () {
                  if (state.currentIndex > 0) {
                    context.read<FundraiserBloc>().add(FundraiserPageChangeEvent(currentIndex: state.currentIndex - 1));
                  } else {
                    if (sl<Navigation>().canPop()) {
                      sl<Navigation>().popFromRoute();
                    }
                  }
                },
                child: Padding(padding: EdgeInsets.only(left: 38.w), child: SvgPicture.asset(R.assets.graphics.svgIcons.backArrow)),
              ),
              SizedBox(height: 26.h),
              PagesBar(activeSegments: (state.currentIndex + 1), totalSegments: 3),
              SizedBox(height: 11.h),
              Center(child: TextWidget('Step ${state.currentIndex +  1} of 3', color: R.palette.lightGrey, size: 14.sp, weight: FontWeight.w500)),
              SizedBox(height: 22.h),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    context.read<FundraiserBloc>().add(FundraiserPageChangeEvent(currentIndex: index));
                  },
                  children: const [FirstFundraiserDetail(), SecondFundraiserDetail(), FundraiserStep3()],
                ),
              ),
              SizedBox(
                height: 63.h,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  switchInCurve: Curves.easeOutBack,
                  switchOutCurve: Curves.easeIn,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: ScaleTransition(scale: animation, child: child),
                    );
                  },
                  child: state.currentIndex == 2
                      ? Center(
                    key: const ValueKey('previewBtn'),
                    child: Container(
                      height: 48.h,
                      width: 294.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        color: R.palette.primary,
                      ),
                      child: Center(
                        child: Text(
                          'preview fundraiser',
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(
                            color: R.palette.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),
                  )
                      : Center(
                    key: const ValueKey('nextCircle'),
                    child: GestureDetector(
                      onTap: () {
                        if (state.currentIndex < pagesCount) {
                          context
                              .read<FundraiserBloc>()
                              .add(FundraiserPageChangeEvent(currentIndex: state.currentIndex + 1));
                        }
                      },
                      child: Container(
                        height: 63.h,
                        width: 63.w,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: R.palette.primary),
                        child: Center(child: SvgPicture.asset(R.assets.graphics.svgIcons.nextArrow)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 56.h),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
