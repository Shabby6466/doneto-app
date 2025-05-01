import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PreviewFundraiser extends StatefulWidget {
  const PreviewFundraiser({super.key});

  @override
  State<PreviewFundraiser> createState() => _PreviewFundraiserState();
}

class _PreviewFundraiserState extends State<PreviewFundraiser> {
  @override
  Widget build(BuildContext context) {
    return Background(
      safeAreaTop: true,
      child: Column(
        children: [
          MyTopBar(
            onTap: () {
              if (sl<Navigation>().canPop()) {
                sl<Navigation>().popFromRoute();
              }
            },
            title: 'preview fundraiser',
          ),
          SizedBox(height: 23.h),
          Container(
            height: 223.h,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Stack(
              children: [
                SizedBox(
                  height: 223.h,
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(R.assets.graphics.pngIcons.bgFlowers, fit: BoxFit.fitWidth),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: Container(
                    height: 38.h,
                    width: 38.w,
                    decoration: BoxDecoration(color: R.palette.white, shape: BoxShape.circle),
                    child: Center(child: SvgPicture.asset(R.assets.graphics.svgIcons.heartIcon)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
