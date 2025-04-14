import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doneto/core/utils/resource/r.dart';

class MyCheckbox extends StatelessWidget {
  const MyCheckbox({super.key, required this.onTap, required this.checked, required this.title});

  final VoidCallback onTap;
  final bool checked;

  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              checked ? CupertinoIcons.checkmark_square_fill : CupertinoIcons.square,
              color: checked ? R.palette.loginBgColor :  Theme.of(context).highlightColor,
              size: 26.sp,
            ),
            SizedBox(width: 6.w),
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontSize: 22.sp,
                    height: 1,
                    fontWeight: FontWeight.w600,
                  ),
            )
          ],
        ),
      ),
    );
  }
}
