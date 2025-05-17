import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:doneto/modules/home/widgets/rounded_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

import '../bloc/home_bloc.dart';

/// Renders a grid of donation cards, backed by a stream of [Fundraiser].
///
/// - [fundraiserStream]: allow overriding the source stream (e.g. city-specific). Defaults to all fundraisers.
/// - [maxItems]: if set, limits the number of items shown.
class DonationCardsGrid extends StatelessWidget {
  final Stream<List<Fundraiser>>? fundraiserStream;
  final int? maxItems;
  final bool? donetoVerified;

  const DonationCardsGrid({super.key, this.fundraiserStream, this.maxItems, this.donetoVerified});

  @override
  Widget build(BuildContext context) {
    final Stream<List<Fundraiser>> stream = fundraiserStream ?? const Stream.empty();
    return Column(
      children: [
        SizedBox(height: 22.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: StreamBuilder<List<Fundraiser>>(
            stream: stream,
            builder: (context, snapshot) {
              final allList = snapshot.data ?? <Fundraiser>[];
              if (context.read<HomeBloc>().state.totalFundraisers != allList.length) {}

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return SizedBox(height: 250.h, child: const Center(child: CircularProgressIndicator()));
                case ConnectionState.active:
                case ConnectionState.done:
                  if (snapshot.hasError) {
                    sl<Logger>().f('Error loading fundraisers ${snapshot.error}');
                    return SizedBox(height: 250.h, child: const Center(child: Text("Something went wrong")));
                  }
                  if (allList.isEmpty) {
                    return SizedBox(height: 250.h, child: const Center(child: Text("No fundraisers available.")));
                  }

                  final displayList = maxItems != null ? allList.take(maxItems!).toList() : allList;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: displayList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12.w,
                          mainAxisSpacing: 12.h,
                          childAspectRatio: donetoVerified ?? false ? 170 / 194 : 181 / 194,
                        ),
                        itemBuilder: (ctx, i) {
                          final f = displayList[i];
                          return _buildDonationCard(
                            f.title,
                            f.photoUrl ?? '',
                            '12 mins',
                            // TODO: replace with actual time calculation
                            f.receivedAmount,
                            f.targetAmount,
                            context,
                            () {
                              sl<Navigation>().pushNamedWithExtra(
                                path: Routes.previewFundraiser,
                                navigationData: PreviewFundraiserNavigationData(
                                  fundraiserTitle: f.title,
                                  imageUrl: f.photoUrl ?? '',
                                  fundraiserId: f.id,
                                  raisedAmount: f.receivedAmount.toString(),
                                  donationsGoal: f.targetAmount.toString(),
                                  owner: f.ownerId,
                                  fundraiserDescription: f.description,
                                ),
                              );
                            },
                            donetoVerified ?? false,
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
  VoidCallback onTap,
  bool donetoVerified,
  //
) {
  final double progress = totalAmount > 0 ? (raised / totalAmount).clamp(0.0, 1.0) : 0.0;

  return GestureDetector(
    onTap: onTap,
    child: Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: SizedBox(
        width: 181.w,
        height: 194.h,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 7.w, right: 17.w),
              color: R.palette.secondary,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(),
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 15.sp, fontWeight: FontWeight.w700, height: 1.3.h, color: R.palette.blackColor),
                  ),
                  SizedBox(height: 17.h),
                  Row(
                    children: [
                      Text(
                        '${raised.toStringAsFixed(0)} raised of ${totalAmount.toStringAsFixed(0)}',
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500, height: 1.3.h, color: R.palette.blackColor),
                      ),
                      SizedBox(width: 3.w),
                      Text(
                        'PKR',
                        style: Theme.of(
                          context,
                        ).textTheme.titleLarge!.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500, height: 1.3.h, color: R.palette.primary),
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
                  Text(
                    'Last donation $timeLeft ago',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(fontSize: 10.sp, fontWeight: FontWeight.w500, height: 1.3.h, color: R.palette.blackColor),
                  ),
                  SizedBox(height: 5.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Visibility(
                      visible: donetoVerified,
                      child: SvgPicture.asset(
                        R.assets.graphics.svgIcons.donetoVerified,
                        width: 10.w,
                        height: 10.h,
                        //
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RoundedCacheImage(
              imageUrl: image,
              placeholderAsset: R.assets.graphics.pngIcons.bgFlowers,
              width: 181.w,
              height: 85.h,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16.r), topLeft: Radius.circular(16.r), topRight: Radius.circular(16.r)),
            ),
          ],
        ),
      ),
    ),
  );
}
