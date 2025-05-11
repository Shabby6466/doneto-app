import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/bloc/fundraiser_bloc.dart';
import 'package:doneto/modules/fundraiser/widgets/underline_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondFundraiserDetail extends StatefulWidget {
  const SecondFundraiserDetail({super.key});

  @override
  State<SecondFundraiserDetail> createState() => _SecondFundraiserDetailState();
}

class _SecondFundraiserDetailState extends State<SecondFundraiserDetail> {
  final TextEditingController _fundraiserTitleController = TextEditingController();
  final TextEditingController _needController = TextEditingController();

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
                'Describe why you’re fundraising',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                  color: R.palette.primary,
                  fontSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Poppins',
                  height: 1.3.h,
                ),
              ),
              SizedBox(height: 22.h),
              Text(
                'Give your fundraiser a title',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 16.h),
              UnderlineTextField(
                hintText: 'e.g Fundraiser for a cancer patient',
                suffixText: '',
                controller: _fundraiserTitleController,
                onChange: (e) {
                  context.read<FundraiserBloc>().add(FundraiserTitleChangeEvent(title: e));
                },
                //
              ),
              SizedBox(height: 32.h),
              Text(
                'Describe your need and situation',
                style: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(color: R.palette.blackColor, fontSize: 16.sp, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
              ),
              SizedBox(height: 16.h),
              MultilineTextArea(
                controller: _needController,
                hintText: 'Hi, I am fundraising...',
                //
                onChange: (e) {
                  context.read<FundraiserBloc>().add(FundraiserDescriptionChangeEvent(description: e));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
