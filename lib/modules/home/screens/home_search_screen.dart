import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/home/bloc/home_bloc.dart';
import 'package:doneto/modules/home/widgets/rounded_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeSearchScreen extends StatelessWidget {
  const HomeSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, cur) => prev.filteredFundraisers != cur.filteredFundraisers || prev.loading != cur.loading,
      builder: (context, state) {
        if (state.loading) {
          return SizedBox(height: 500.h, child: const Center(child: CircularProgressIndicator()));
        }

        final results = state.filteredFundraisers;
        if (results.isEmpty) {
          return SizedBox(height: 500.h, child: const Center(child: Text("No fundraisers found.")));
        }
        return Padding(
          padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: results.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1, mainAxisSpacing: 12.h, childAspectRatio: 181 / 150),
            itemBuilder: (ctx, i) {
              final f = results[i];
              return _buildFundraiserSearchContainer(context, f.title, f.photoUrl ?? '', '12 min', f.receivedAmount, f.targetAmount, () {
                sl<Navigation>().pushNamedWithExtra(
                  path: Routes.previewFundraiser,
                  navigationData: PreviewFundraiserNavigationData(
                    fundraiserId: f.id,
                    fundraiserTitle: f.title,
                    fundraiserDescription: f.description,
                    imageUrl: f.photoUrl ?? '',
                    owner: f.ownerId,
                    raisedAmount: f.receivedAmount.toString(),
                    donationsGoal: f.targetAmount.toString(),
                  ),
                );
              });
            },
          ),
        );
      },
    );
  }
}

Widget _buildFundraiserSearchContainer(
  BuildContext context,
  String title,
  String image,
  String timeLeft,
  double raised,
  double totalAmount,
  final VoidCallback onTap,
  //
) {
  final double progress = totalAmount > 0 ? (raised / totalAmount).clamp(0.0, 1.0) : 0.0;
  return GestureDetector(
    onTap: onTap,
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          height: 286.h,
          width: 386.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            color: R.palette.secondary,
            //
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              Text(
                title,
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  height: 1.3.h,
                  color: R.palette.blackColor,
                  //
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'With a shattered heart, I share the unbearable news of my beloved husband, Gurvinder Singh lovingly called "Sodhi", who tragically passed away in a road train accident.',
                maxLines: 2,
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 9.sp,
                  fontWeight: FontWeight.w300,
                  height: 1.3.h,
                  color: R.palette.blackColor,
                  //
                ),
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Text(
                    '${raised.toStringAsFixed(0)}  raised of ${totalAmount.toStringAsFixed(0)}',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.3.h,
                      color: R.palette.blackColor,
                      //
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    'PKR',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.3.h,
                      color: R.palette.primary,
                      //
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: SizedBox(
                  height: 8.h,
                  child: LinearProgressIndicator(
                    minHeight: 8,
                    value: progress,
                    backgroundColor: R.palette.blackColor.withValues(alpha: 0.06),
                    valueColor: AlwaysStoppedAnimation(R.palette.primary),
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Last donation $timeLeft ago',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.3.h,
                    color: R.palette.blackColor,
                    //
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
          ),
        ),
        RoundedCacheImage(
          imageUrl: image,
          placeholderAsset: R.assets.graphics.pngIcons.bgFlowers,
          width: 353.w,
          height: 137.h,
          fit: BoxFit.cover,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15.r),
            topLeft: Radius.circular(15.r),
            topRight: Radius.circular(15.r),
            //
          ),
        ),
      ],
    ),
  );
}
