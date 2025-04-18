import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashIndex extends StatefulWidget {
  const SplashIndex({super.key});

  @override
  State<SplashIndex> createState() => _SplashIndexState();
}

class _SplashIndexState extends State<SplashIndex> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
    ).then((_) => sl<Navigation>().go(Routes.auth));
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      bgColor: R.palette.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(flex: 3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 70.w),
            child: Center(child: Image.asset(height: 108.h, width: 262.w, R.assets.graphics.pngIcons.donetoWhiteLogo)),
          ),
          const Spacer(),
          Image.asset(R.assets.graphics.pngIcons.flowers),
        ],
      ),
    );
  }
}
