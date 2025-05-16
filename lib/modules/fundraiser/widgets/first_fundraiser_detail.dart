import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/bloc/fundraiser_bloc.dart';
import 'package:doneto/modules/fundraiser/widgets/underline_text_field.dart';
import 'package:doneto/modules/fundraiser/widgets/donation_disclaimer.dart';
import 'package:doneto/modules/home/screens/fundraiser_category_field.dart';
import 'package:doneto/modules/home/screens/fundraiser_country_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:country_picker/country_picker.dart';


class FirstFundraiserDetail extends StatefulWidget {
  const FirstFundraiserDetail({super.key});

  @override
  State<FirstFundraiserDetail> createState() => _FirstFundraiserDetailState();
}

class _FirstFundraiserDetailState extends State<FirstFundraiserDetail> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _amountController.dispose();
    _categoryController.dispose();
    _countryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FundraiserBloc, FundraiserState>(
      builder: (context, state) {
        return Background(
          safeAreaTop: true,
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
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: R.palette.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 11.h),
                  UnderlineTextField(
                    hintText: 'Enter amount',
                    suffixText: 'PKR',
                    controller: _amountController,
                    inputType: TextInputType.phone,
                    onChange: (e) {
                      context.read<FundraiserBloc>().add(FundraiserAmountChangeEvent(amount: e));
                    },
                    //
                  ),
                  SizedBox(height: 35.h),
                  Text(
                    'What kind of fundraiser are you creating?',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: R.palette.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () async {
                      final selectedCategory = await showModalBottomSheet<FundraiserCategory>(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
                        builder: (_) => _categorySelection(context),
                      );

                      if (selectedCategory != null) {
                        _categoryController.text = selectedCategory.displayName;
                        if (context.mounted) {
                          context.read<FundraiserBloc>().add(FundraiserCategoryChangeEvent(category: selectedCategory.displayName));
                        }
                      }
                    },
                    child: FundraiserCategoryField(name: state.category),
                  ),
                  Divider(color: Colors.grey[300]),
                  SizedBox(height: 35.h),
                  Text(
                    'Where are you fundraising from?',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      color: R.palette.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () async {
                      final selectedCountry = await showModalBottomSheet<Country>(
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.r))),
                        builder: (_) => _countrySelection(context),
                      );

                      if (selectedCountry != null) {
                        _categoryController.text = selectedCountry.displayName;
                        if (context.mounted) {
                          context.read<FundraiserBloc>().add(FundraiserCountryChangeEvent(country: selectedCountry.displayName));
                        }
                      }
                    },
                    child: const FundraiserCountryField(country: ''),
                  ),
                  Divider(color: Colors.grey[300]),
                  SizedBox(height: 35.h),
                  Row(
                    spacing: 3.51.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(R.assets.graphics.svgIcons.gpsIcon),
                      Text(
                        'use current location',
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                          color: R.palette.primary,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
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
      },
    );
  }
}

/*
Category Popup btn
*/
Widget _categorySelection(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 20.h),
    height: 600.h,
    width: 400.w,
    decoration: BoxDecoration(color: R.palette.white, borderRadius: BorderRadius.circular(16.r)),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Row(
            children: [
              GestureDetector(onTap: () => Navigator.of(context).pop(), child: SvgPicture.asset(R.assets.graphics.svgIcons.backArrow)),
              const Spacer(),
              Text(
                'Select a category',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(height: 40.5.h),
        Text(
          'Pick the category that best represents your fundraiser',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.displayLarge!.copyWith(color: R.palette.textFieldBgColor, fontSize: 16.sp, fontWeight: FontWeight.w500, height: 1.5.h),
        ),
        SizedBox(height: 14.h),
        Padding(padding: EdgeInsets.symmetric(horizontal: 20.h), child: Divider(color: R.palette.textFieldBgColor)),
        SizedBox(height: 26.h),
        Expanded(
          child: SingleChildScrollView(
            child: Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children:
                  FundraiserCategory.values.map((cat) {
                    return InkWell(
                      onTap: () => Navigator.of(context).pop(cat),
                      borderRadius: BorderRadius.circular(48.r),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                        decoration: BoxDecoration(
                          color: R.palette.white,
                          borderRadius: BorderRadius.circular(48.r),
                          border: Border.all(color: R.palette.textFieldBgColor),
                        ),
                        child: Text(
                          cat.displayName,
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge!.copyWith(color: R.palette.blackColor, fontSize: 15.sp, fontWeight: FontWeight.w400),
                        ),
                      ),
                    );
                  }).toList(),
            ),
          ),
        ),
      ],
    ),
  );
}

//
// enum

enum FundraiserCategory {
  animals,
  business,
  community,
  competitions,
  creative,
  education,
  emergencies,
  environment,
  events,
  faith,
  family,
  funeralMemorial,
  medical,
  monthlyBills,
  newlyweds,
  wishes,
  other,
}

extension FundraiserCategoryX on FundraiserCategory {
  String get displayName {
    switch (this) {
      case FundraiserCategory.animals:
        return 'Animals';
      case FundraiserCategory.business:
        return 'Business';
      case FundraiserCategory.community:
        return 'Community';
      case FundraiserCategory.competitions:
        return 'Competitions';
      case FundraiserCategory.creative:
        return 'Creative';
      case FundraiserCategory.education:
        return 'Education';
      case FundraiserCategory.emergencies:
        return 'Emergencies';
      case FundraiserCategory.environment:
        return 'Environment';
      case FundraiserCategory.events:
        return 'Events';
      case FundraiserCategory.faith:
        return 'Faith';
      case FundraiserCategory.family:
        return 'Family';
      case FundraiserCategory.funeralMemorial:
        return 'Funeral & Memorial';
      case FundraiserCategory.medical:
        return 'Medical';
      case FundraiserCategory.monthlyBills:
        return 'Monthly Bills';
      case FundraiserCategory.newlyweds:
        return 'Newlyweds';
      case FundraiserCategory.wishes:
        return 'Wishes';
      case FundraiserCategory.other:
        return 'Other';
    }
  }
}

/*
  Country Selection
*/

Widget _countrySelection(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 5.h, vertical: 20.h),
    height: 600.h,
    decoration: BoxDecoration(color: R.palette.white, borderRadius: BorderRadius.circular(16.r)),
    child: Column(
      children: [
        // — header row —
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Row(
            children: [
              GestureDetector(onTap: () => Navigator.of(context).pop(), child: SvgPicture.asset(R.assets.graphics.svgIcons.backArrow)),
              const Spacer(),
              Text(
                'Select your country',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        SizedBox(height: 40.5.h),
        Text(
          'Search your country',
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.displayLarge!.copyWith(color: R.palette.textFieldBgColor, fontSize: 16.sp, fontWeight: FontWeight.w500, height: 1.5.h),
        ),
        SizedBox(height: 14.h),
        Padding(padding: EdgeInsets.symmetric(horizontal: 20.h), child: Divider(color: R.palette.textFieldBgColor)),
        SizedBox(height: 26.h),

        // — the country list with built-in search —
        // Expanded(
        //   child: CountryListView(
        //     onCountrySelected: (country) {
        //       Navigator.of(context).pop(country);
        //     },
        //     // optional: copy your sheet theming in here
        //     countryListTheme: CountryListThemeData(
        //       // match your sheet’s border radius
        //       borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        //       inputDecoration: InputDecoration(
        //         labelText: 'Search',
        //         hintText: 'Start typing to search',
        //         prefixIcon: const Icon(Icons.search),
        //         border: OutlineInputBorder(borderSide: BorderSide(color: R.palette.textFieldBgColor.withOpacity(0.2))),
        //       ),
        //       searchTextStyle: TextStyle(color: R.palette.primary, fontSize: 16.sp),
        //     ),
        //   ),
        // ),
      ],
    ),
  );
}
