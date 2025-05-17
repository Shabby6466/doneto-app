import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class FundraiserStoryCard extends StatelessWidget {
  final String story;

  const FundraiserStoryCard({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          ReadMoreText(
            story,
            trimLines: 5,
            trimMode: TrimMode.Length,
            trimCollapsedText: 'Read more...',
            trimExpandedText: 'Read less',
            moreStyle: Theme.of(context).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 15.sp, fontWeight: FontWeight.w600),
            lessStyle: Theme.of(context).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontWeight: FontWeight.w600, fontSize: 15.sp),
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500, fontSize: 15.sp, height: 1.4.h),
          ),
        ],
      ),
    );
  }
}
