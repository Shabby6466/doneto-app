import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/fundraiser/widgets/fundraiser_for_people_text_btn.dart';
import 'package:doneto/modules/home/bloc/home_bloc.dart';
import 'package:doneto/modules/home/widgets/donation_cards_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  late int totalFundraisers;
  @override
  void initState() {
    super.initState();
    totalFundraisers = context.read<HomeBloc>().state.totalFundraisers;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 34.h),
        const FundraiserForPeopleTextBtn(),
        SizedBox(height: 31.h),
        Padding(padding: EdgeInsets.symmetric(horizontal: 23.w), child: Divider(color: R.palette.gray)),
        Padding(
          padding:  EdgeInsets.only(left: 16.w, right: 16.w,top: 12.h),
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
              SvgPicture.asset(R.assets.graphics.svgIcons.gpsIcon),
              SizedBox(width: 3.5.w),
              Text(
                totalFundraisers.toString(),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontSize: 13.sp, fontWeight: FontWeight.w500, height: 1.2.h, color: R.palette.primary),
              ),
            ],
          ),
        ),
        const DonationCardsGrid(),
        SizedBox(height: 50.h),
      ],
    );
  }
}
