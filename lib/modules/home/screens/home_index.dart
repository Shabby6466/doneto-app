import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({super.key});

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  @override
  Widget build(BuildContext context) {
    return Background(
      safeAreaTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 16.h),
            Center(
              child: Image.asset(
                width: 182.w,
              R.assets.graphics.pngIcons.donetoLogo),
            ),
           ],
        ),
    );
  }
}
