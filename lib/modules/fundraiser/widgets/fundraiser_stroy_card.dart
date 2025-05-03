import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:readmore/readmore.dart';

class FundraiserStoryCard extends StatelessWidget {
  const FundraiserStoryCard({super.key});

  static const _title =
      'Help Maninder Kaur & Son Williamjeet Singh (6 years) after Gurvinder’s Tragic Passing.';
  static const _body = '''
With a shattered heart, I share the unbearable news of my beloved husband, Gurvinder Singh lovingly called “Sodhi,” who tragically passed away in a road train accident near Wongan Hills on March 30, 2025 leaving behind our son Williamjeet Singh, me and his elder parents. He was only 34 years old—taken from us far too soon.
His sudden loss has left our family not only emotionally devastated but also facing overwhelming financial challenges: funeral expenses, household bills, and the ongoing care and education of our young son.

I am humbly reaching out for your support. Any contribution—no matter how small—will help us cover funeral costs, sustain essential living expenses, and secure Williamjeet’s schooling.
''';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      elevation: 0.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              height: 1.4.h,
            ),
          ),
          SizedBox(height: 10.h),
          ReadMoreText(
            _body,
            trimLines: 5,
            trimMode: TrimMode.Length,
            trimCollapsedText: 'Read more...',
            trimExpandedText: 'Read less',
            moreStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: R.palette.primary,
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
            ),
            lessStyle:Theme.of(context).textTheme.displayLarge!.copyWith(
            color: R.palette.primary,
            fontWeight: FontWeight.w600,
              fontSize: 15.sp,
          ),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              height: 1.4.h,
            ),
          ),
        ],
      ),
    );
  }
}
