import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:doneto/modules/fundraiser/usecases/watch_all_fundraisers.dart';
import 'package:doneto/modules/home/widgets/rounded_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

class DonationCardsGrid extends StatefulWidget {
  const DonationCardsGrid({super.key});

  @override
  State<DonationCardsGrid> createState() => _DonationCardsGridState();
}

class _DonationCardsGridState extends State<DonationCardsGrid> {
  @override
  Widget build(BuildContext context) {
    final stream = sl<WatchAllFundraisersUseCase>().calling(NoParams());
    return Column(
      children: [
        SizedBox(height: 22.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: StreamBuilder<List<Fundraiser>>(
            stream: stream,
            builder: (context, snapshot) {
              final total = snapshot.data?.length ?? 0;
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    sl<Logger>().f('Error loading fundraisers ${snapshot.error}');
                    return const Center(child: Text("Something went wrong"));
                  }
                  final list = snapshot.data ?? [];
                  if (list.isEmpty) {
                    return const Center(child: Text("No fundraisers available."));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Islamabad, PK',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w800,
                              height: 1.3.h,
                              color: R.palette.blackColor,
                            ),
                          ),
                          const Spacer(),
                          SvgPicture.asset(R.assets.graphics.svgIcons.gpsIcon),
                          SizedBox(width: 3.5.w),
                          Text(
                            total.toString(),
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge!.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500, height: 1.2.h, color: R.palette.primary),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: list.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: 181 / 194,
                        ),
                        itemBuilder: (ctx, i) {
                          final f = list[i];
                          final title = f.title;
                          final imageUrl = f.photoUrl ?? '';
                          final timeLeft = '12 mins';
                          final double raised = f.receivedAmount;
                          final double totalAmount = f.targetAmount;
                          return _buildDonationCard(
                            title,
                            imageUrl,
                            timeLeft,
                            raised,
                            totalAmount,
                            context,
                            () {
                              sl<Navigation>().pushNamedWithExtra(
                                path: Routes.previewFundraiser,
                                navigationData: PreviewFundraiserNavigationData(
                                  fundraiserTitle: title,
                                  imageUrl: imageUrl,
                                  fundraiserId: f.id,
                                  raisedAmount: raised.toString(),
                                  donationsGoal: totalAmount.toString(),
                                  owner: f.ownerId,
                                  fundraiserDescription: f.description,
                                ),
                              );
                            },
                            //
                          );
                        },
                      ),
                    ],
                  );
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }
}

Widget _buildDonationCard(
  String title,
  String image,
  String timeLeft,
  double raised,
  double totalAmount,
  BuildContext context,
  final VoidCallback onTap,
  //
) {
  final double progress = totalAmount > 0 ? (raised / totalAmount).clamp(0.0, 1.0) : 0.0;
  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: SizedBox(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 7.w, right: 17.w),
              height: 194.h,
              width: 181.w,
              color: R.palette.secondary,
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
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.3.h,
                      color: R.palette.blackColor,
                      //
                    ),
                  ),
                  SizedBox(height: 17.h),
                  Row(
                    children: [
                      Text(
                        '${raised.toStringAsFixed(0)}  raised of ${totalAmount.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 10.sp,
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
                          fontSize: 10.sp,
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
                    alignment: Alignment.centerLeft,
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
                  SizedBox(height: 5.h),
                ],
              ),
            ),
            RoundedCacheImage(
              imageUrl: image,
              placeholderAsset: R.assets.graphics.pngIcons.bgFlowers,
              width: 181.w,
              height: 85.h,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.r),
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
                //
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
