import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/home/widgets/custom_swipe_deck.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreIndex extends StatefulWidget {
  const ExploreIndex({super.key});

  @override
  State<ExploreIndex> createState() => _ExploreIndexState();
}

class _ExploreIndexState extends State<ExploreIndex> {
  final List<FundraiserData> _featured = [
    FundraiserData(
      imageUrl: 'https://res.cloudinary.com/dw1ufbv8u/image/upload/v1747071269/doneto/mnfvhsxhlw9dnjov7dyq.jpg',
      title: 'Help fizza to go to a school',
      subtitle:
          'Help Maninder Kaur & Son Williamjeet Singh (6 years) after Gurvinder’s Tragic Passing. Help Maninder Kaur & Son Williamjeet Singh (6 years) after Gurvinder’s Tragic Passing. Help Maninder Kaur & Son Williamjeet Singh (6 years) after Gurvinder’s Tragic Passing.',
      raised: 23454,
      goal: 40000,
      lastDonation: 'Last donation 23 mins ago',
    ),
    FundraiserData(
      imageUrl: 'https://res.cloudinary.com/dw1ufbv8u/image/upload/v1747071269/doneto/mnfvhsxhlw9dnjov7dyq.jpg',
      title: 'I am shoaib ',
      subtitle:
          'Help Maninder Kaur & Son Williamjeet Singh (6 years) after Gurvinder’s Tragic Passing.Help Maninder Kaur & Son Williamjeet Singh (6 years) after Gurvinder’s Tragic Passing. Help Maninder Kaur & Son Williamjeet Singh (6 years) after Gurvinder’s Tragic Passing.',
      raised: 23454,
      goal: 40000,
      lastDonation: 'Last donation 23 mins ago',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Background(
      safeAreaTop: true,
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
            child: FractionallySizedBox(widthFactor: 0.8, child: CustomSwipeDeck(items: _featured)),
          ),
        ],
      ),
    );
  }
}
