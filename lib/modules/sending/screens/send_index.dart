import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/widgets/fundraiser_for_people_text_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendIndex extends StatefulWidget {
  const SendIndex({super.key});

  @override
  State<SendIndex> createState() => _SendIndexState();
}

class _SendIndexState extends State<SendIndex> {
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
              R.assets.graphics.pngIcons.donetoLogo,
              //
            ),
          ),
          SizedBox(height: 80.h),
          const FundraiserForPeopleTextBtn(),
        ],
      ),
    );
  }
}
