import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTopBar extends StatefulWidget {
  final GestureTapCallback onTap;
  final String title;

  const MyTopBar({super.key, required this.onTap, required this.title});

  @override
  State<MyTopBar> createState() => _MyTopBarState();
}

class _MyTopBarState extends State<MyTopBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 38.w),
      child: Row(
        children: [
          GestureDetector(onTap: widget.onTap, child: Icon(Icons.arrow_back, color: R.palette.blackColor)),
          const Spacer(flex: 2),
          Text(
            widget.title,
            style: Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w700, height: 1.h, color: R.palette.blackColor),
          ),
          const Spacer(flex: 3),
        ],
      ),
    );
  }
}
