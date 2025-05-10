import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/custom_textfield.dart';
import 'package:doneto/modules/fundraiser/bloc/fundraiser_bloc.dart';
import 'package:doneto/modules/fundraiser/widgets/underline_text_field.dart';
import 'package:doneto/modules/fundraiser/widgets/donation_disclaimer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FirstFundraiserDetail extends StatefulWidget {
  const FirstFundraiserDetail({super.key});

  @override
  State<FirstFundraiserDetail> createState() => _FirstFundraiserDetailState();
}

class _FirstFundraiserDetailState extends State<FirstFundraiserDetail> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Padding(
        padding: EdgeInsets.only(left: 20.w, right: 25.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fundraiser Details',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 30.sp, fontWeight: FontWeight.w700, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 22.h),
              Text(
                'How much would you like to raise?',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 11.h),
              UnderlineTextField(
                hintText: 'Enter amount',
                suffixText: 'PKR',
                controller: _amountController,
                onChange: (e) {
                  context.read<FundraiserBloc>().add(FundraiserAmountEvent(fundraiserAmount: e.toString()));
                },
                //
              ),
              SizedBox(height: 35.h),
              Text(
                'What kind of fundraiser are you creating?',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 11.h),
              UnderlineTextField(
                hintText: 'Select a category',
                suffixText: '',
                controller: _categoryController,
                onChange: (e) {
                  // context.read<FundraiserBloc>().add(FundraiserCategoryEvent(fundraiserCategory: e.toString()));
                },
                //
              ),
              SizedBox(height: 35.h),
              Text(
                'Where are you fundraising from?',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 11.h),
              UnderlineTextField(
                hintText: 'Search your ZIP code',
                suffixText: '',
                controller: _locationController,
                onChange: (e) {
                  // context.read<FundraiserBloc>().add(FundraiserLocationEvent(location: e.toString()));
                },
                //
              ),
              SizedBox(height: 20.h),
              Row(
                spacing: 3.51.w,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(R.assets.graphics.svgIcons.gpsIcon),
                  Text(
                    'use current location',
                    style: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              DonationDisclaimer(onPrivacyPolicyTap: () {}, onTermsTap: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
