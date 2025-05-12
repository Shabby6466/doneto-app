import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/utils/utitily_methods/utils.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/cache_network_image.dart';
import 'package:doneto/modules/auth/bloc/auth_bloc.dart';
import 'package:doneto/modules/fundraiser/usecases/get_my_fundraisers_useCase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:logger/logger.dart';
import '../../fundraiser/widgets/doneto_button.dart';

class ProfileIndex extends StatefulWidget {
  const ProfileIndex({super.key});

  @override
  State<ProfileIndex> createState() => _ProfileIndexState();
}

class _ProfileIndexState extends State<ProfileIndex> {
  @override
  void initState() {
    super.initState();
  }

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
        final stream = sl<GetMyFundraisersUseCase>().calling(NoParams());
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
                      Image.asset(R.assets.graphics.pngIcons.donetoLogo, width: 182.w),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          context.read<AuthBloc>().add(LogoutEvent());
                        },
                        child: SvgPicture.asset(R.assets.graphics.svgIcons.redCross, width: 35.h),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25.95.h),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircularCacheNetworkImage(
                      size: 150.h,
                      backgroundColor: R.palette.white,
                      imageUrl: state.imageUrl!,
                      errorIconPath: R.assets.graphics.svgIcons.cameraIcon,
                    ),
                    Positioned(
                      right: 8.w,
                      bottom: 8.h,
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(color: R.palette.white, shape: BoxShape.circle),
                        child: SvgPicture.asset(R.assets.graphics.svgIcons.cameraIcon),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state.fullName!,
                    style: Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w800, color: R.palette.blackColor, height: 1.5.h),
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 318.w,
                    alignment: Alignment.center,
                    child: Text(
                      'Description',
                      textAlign: TextAlign.center,
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium!.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w600, color: R.palette.blackColor, height: 1.4.h),
                    ),
                  ),
                ),
                SizedBox(height: 43.h),
                Padding(padding: const EdgeInsets.only(right: 113, left: 115), child: DonetoButton(title: 'Share Profile', onTap: () {})),
                SizedBox(height: 28.h),
                Text(
                  'My Fundraisers',
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600, color: R.palette.blackColor, height: 1.4.h),
                ),
                SizedBox(height: 24.h),
                StreamBuilder<List<Fundraiser>>(
                  stream: stream,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());

                      case ConnectionState.active:
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          sl<Logger>().f('My Fundraiser Error | ${snapshot.error}');
                          return const Center(child: Text("Something went wrong"));
                        }

                        final fundraisers = snapshot.data ?? [];
                        if (fundraisers.isEmpty) {
                          return const Center(child: Text("No fundraisers yet."));
                        }

                        return SizedBox(
                          height: 250.h,
                          child: ListView.separated(
                            itemCount: fundraisers.length,
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            separatorBuilder: (context, index) => SizedBox(height: 15.h),
                            itemBuilder: (ctx, i) {
                              final f = fundraisers[i];
                              return _buildFundraiserContainer(
                                context,
                                f.title,
                                f.photoUrl ?? '',
                                f.targetAmount,
                                f.supporters,
                                f.receivedAmount,
                                //
                              );
                            },
                          ),
                        );

                      default:
                        return const SizedBox.shrink();
                    }
                  },
                ),

                SizedBox(height: 41.h),
                Text(
                  'social links',
                  style: Theme.of(
                    context,
                  ).textTheme.labelMedium!.copyWith(fontSize: 20.sp, fontWeight: FontWeight.w600, color: R.palette.blackColor, height: 1.4.h),
                ),
                SizedBox(height: 25.h),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  width: 120.w,
                  height: 50.h,
                  decoration: BoxDecoration(color: R.palette.skin, borderRadius: BorderRadius.circular(16.r)),
                  child: Row(
                    spacing: 4.w,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPicture.asset(R.assets.graphics.svgIcons.instaLogo, height: 30.h, width: 30.w),
                      Center(
                        child: Text(
                          'Instagram',
                          style: Theme.of(
                            context,
                          ).textTheme.labelMedium!.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w400, color: R.palette.blackColor, height: 1.4.h),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 59.h),
                Container(
                  padding: EdgeInsets.only(top: 17, left: 14.w, right: 97.w),
                  height: 112.h,
                  width: 326.w,
                  decoration: BoxDecoration(shape: BoxShape.rectangle, color: R.palette.skin, borderRadius: BorderRadius.circular(20.r)),
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: R.palette.blackColor,
                            height: 1.2.h,
                          ), // inherit default text style
                          children: [
                            TextSpan(text: 'share your profile', style: TextStyle(color: R.palette.primary)),

                            const TextSpan(text: ' to inspire people to help', style: TextStyle(color: Colors.black)),
                          ],
                        ),
                      ),
                      SizedBox(height: 21.h),
                      Row(
                        children: [
                          const Text('share profile '),
                          SvgPicture.asset(
                            R.assets.graphics.svgIcons.nextArrow,
                            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcATop),
                            width: 10.w,
                            height: 5.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget _buildFundraiserContainer(
  BuildContext context,
  String title,
  String image,
  double amount,
  int supporters,
  double raisedAmount,
  //
) {
  return Padding(
    padding: EdgeInsets.only(right: 12.w, left: 12.w),
    child: Container(
      padding: EdgeInsets.only(right: 20.w),
      height: 85.h,
      width: 354.w,
      decoration: BoxDecoration(shape: BoxShape.rectangle, color: R.palette.secondary, borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              bottomLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
              //
            ),
            child: Image.network(image, height: 85.h, width: 78.h, fit: BoxFit.fill),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5.h),
                Text(
                  '$supporters supporters',
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.w600, fontSize: 11.sp),
                ),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w800, fontSize: 15.sp),
                ),
                SizedBox(height: 5.h),
                LinearProgressIndicator(
                  minHeight: 5,
                  value: 0.25,
                  backgroundColor: R.palette.white,
                  valueColor: AlwaysStoppedAnimation(R.palette.primary),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Text(
                      '${raisedAmount.toString()} raised of ${amount.toString()}',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w100, fontSize: 10.sp),
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'PKR',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.w100,
                        fontSize: 10.sp,
                        color: R.palette.primary,
                        //
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
