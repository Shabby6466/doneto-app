import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FundraiserCountryField extends StatefulWidget {
  final String country;

  const FundraiserCountryField({super.key, required this.country});

  @override
  State<FundraiserCountryField> createState() => _FundraiserCountryFieldState();
}

class _FundraiserCountryFieldState extends State<FundraiserCountryField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: R.palette.transparent,
      height: 28.h,
      child: Row(
        children: [
          Text(
            widget.country.isNotEmpty ? widget.country : 'Enter your country',
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.grey[500],
              //
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            height: 8.h,
            width: 8.w,
            R.assets.graphics.svgIcons.dropDownArrow,
            colorFilter: ColorFilter.mode(R.palette.primary, BlendMode.srcATop),
            //
          ),
        ],
      ),
    );
  }
}
