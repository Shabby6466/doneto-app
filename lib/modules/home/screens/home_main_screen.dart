import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/fundraiser/widgets/fundraiser_for_people_text_btn.dart';
import 'package:doneto/modules/home/widgets/donation_cards_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 34.h),
        const FundraiserForPeopleTextBtn(),
        SizedBox(height: 31.h),
        Padding(padding: EdgeInsets.symmetric(horizontal: 23.w), child: Divider(color: R.palette.gray)),
        const DonationCardsGrid(),
        SizedBox(height: 50.h),
      ],
    );
  }
}
