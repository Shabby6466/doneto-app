import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/usecases/watch_all_fundraisers.dart';
import 'package:doneto/modules/home/bloc/home_bloc.dart';
import 'package:doneto/modules/home/widgets/custom_swipe_deck.dart';
import 'package:doneto/modules/home/widgets/donation_cards_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreIndex extends StatefulWidget {
  const ExploreIndex({super.key});

  @override
  State<ExploreIndex> createState() => _ExploreIndexState();
}

class _ExploreIndexState extends State<ExploreIndex> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(FeaturedFundraisersEvent());
    context.read<HomeBloc>().add(DonetoVerifiedFundraisersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (ctx, state) {},
      builder: (ctx, state) {
        final stream = sl<WatchAllFundraisersUseCase>().calling(NoParams());
        return Background(
          safeAreaTop: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Center(child: Image.asset(R.assets.graphics.pngIcons.donetoLogo, width: 182.w)),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Text(
                    'Featured Fundraisers',
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w800, color: R.palette.blackColor, height: 1.5),
                  ),
                ),
                SizedBox(height: 30.h),
                Container(
                  height: 450.h,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: CustomSwipeDeck(items: state.featuredFundraisers),
                ),
                SizedBox(height: 30.h),
                Padding(padding: EdgeInsets.symmetric(horizontal: 18.w), child: Divider(color: R.palette.gray)),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Doneto Verified',
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w800, color: R.palette.blackColor, height: 1.5),
                      ),
                      GestureDetector(
                        onTap: () => sl<Navigation>().push(path: Routes.donetoVerifiedFundraisers),
                        child: Text(
                          'see all',
                          style: Theme.of(
                            context,
                          ).textTheme.labelMedium!.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300, color: R.palette.blackColor, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
                DonationCardsGrid(maxItems: 2, fundraiserStream: state.donetoVerifiedFundraisers),
                SizedBox(height: 20.h),
                Padding(padding: EdgeInsets.symmetric(horizontal: 18.w), child: Divider(color: R.palette.gray)),
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Explore Fundraisers',
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium!.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w800, color: R.palette.blackColor, height: 1.5),
                      ),
                      GestureDetector(
                        onTap: () {
                          sl<Navigation>().push(path: Routes.exploreAllFundraisers);
                        },
                        child: Text(
                          'see all',
                          style: Theme.of(
                            context,
                          ).textTheme.labelMedium!.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w300, color: R.palette.blackColor, height: 1.5),
                        ),
                      ),
                    ],
                  ),
                ),
                DonationCardsGrid(maxItems: 4, fundraiserStream: stream),
                SizedBox(height: 30.h),
                Padding(padding: EdgeInsets.symmetric(horizontal: 18.w), child: Divider(color: R.palette.gray)),
              ],
            ),
          ),
        );
      },
    );
  }
}
