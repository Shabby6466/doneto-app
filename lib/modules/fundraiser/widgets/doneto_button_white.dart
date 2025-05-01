import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class DonetoButtonWhite extends StatefulWidget {
  final String title;
  const DonetoButtonWhite({super.key, required this.title});

  @override
  State<DonetoButtonWhite> createState() => _DonetoButtonWhiteState();
}

class _DonetoButtonWhiteState extends State<DonetoButtonWhite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        color: R.palette.white,
        border: Border.all(color: R.palette.primary),
      ),
      child: Center(
        child: Text(
          widget.title,
          style: Theme.of(context).textTheme.displayLarge!.copyWith(
            color: R.palette.primary,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
