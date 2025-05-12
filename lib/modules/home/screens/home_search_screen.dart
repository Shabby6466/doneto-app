import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/fundraiser_model.dart';
import 'package:doneto/modules/fundraiser/usecases/watch_all_fundraisers.dart';
import 'package:doneto/modules/home/widgets/rounded_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

class HomeSearchScreen extends StatefulWidget {
  const HomeSearchScreen({super.key});

  @override
  State<HomeSearchScreen> createState() => _HomeSearchScreenState();
}

class _HomeSearchScreenState extends State<HomeSearchScreen> {
  final stream = sl<WatchAllFundraisersUseCase>().calling(NoParams());

  @override
  Widget build(BuildContext context) {
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
                  return Padding(
                    padding: EdgeInsets.only(left: 8.w, right: 10.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 8.w, right: 10.w),
                          child: Row(
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
                              SizedBox(width: 3.5.w),
                              Text(
                                total.toString(),
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.2.h,
                                  color: R.palette.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: list.length,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 12.h,
                            childAspectRatio: 181 / 150,
                          ),
                          itemBuilder: (ctx, i) {
                            final f = list[i];
                            final title = f.title;
                            final imageUrl = f.photoUrl ?? '';
                            final timeLeft = '12 mins';
                            final double raised = f.receivedAmount;
                            final double totalAmount = f.targetAmount;
                            return _buildFundraiserSearchContainer(
                              title,
                              imageUrl,
                              timeLeft,
                              raised,
                              totalAmount,
                              context,
                              //
                            );
                          },
                        ),
                      ],
                    ),
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

Widget _buildFundraiserSearchContainer(
  String title,
  String image,
  String timeLeft,
  double raised,
  double totalAmount,
  BuildContext context,
  //
) {
  final double progress = totalAmount > 0 ? (raised / totalAmount).clamp(0.0, 1.0) : 0.0;
  return Stack(
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
  );
}
