import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/text_widget.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button_white.dart';
import 'package:doneto/modules/fundraiser/widgets/fundraiser_stroy_card.dart';
import 'package:doneto/modules/fundraiser/widgets/publish_donation_bottom_popup.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PreviewFundraiser extends StatefulWidget {
  const PreviewFundraiser({super.key});

  @override
  State<PreviewFundraiser> createState() => _PreviewFundraiserState();
}

class _PreviewFundraiserState extends State<PreviewFundraiser> {
  final PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final body = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MyTopBar(
          onTap: () {
            if (sl<Navigation>().canPop()) sl<Navigation>().popFromRoute();
          },
          title: 'preview fundraiser',
        ),
        SizedBox(height: 23.h),
        SizedBox(
          height: 223.h,
          width: double.infinity,
          child: Stack(
            children: [
              Image.asset(R.assets.graphics.pngIcons.bgFlowers, fit: BoxFit.cover, width: double.infinity),
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
        SizedBox(height: 13.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextWidget('Support to provide clean\nwater to the unprivileged', size: 20.h, height: 1.1.h, weight: FontWeight.w700),
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: TextWidget('PKR 3,000,000 GOAL · 1.7k donations', size: 15.sp, weight: FontWeight.w300, color: R.palette.lightGray),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 17.h),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20.w), child: const DonetoButton(title: "DONATE NOW")),
                SizedBox(height: 11.h),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20.w), child: const DonetoButtonWhite(title: "SHARE")),
                SizedBox(height: 22.h),
                Center(
                  child: Text(
                    'PKR 2,785,254 RAISED',
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(fontSize: 24.sp, fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(height: 15.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 23.w),
                  child: Row(
                    children: [
                      Container(
                        height: 49.h,
                        width: 49.w,
                        decoration: BoxDecoration(color: R.palette.lightGrey2, shape: BoxShape.circle),
                        child: Center(child: SvgPicture.asset(R.assets.graphics.svgIcons.organizerGrey, width: 24, height: 24)),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text('bondh-e-shams is the organizer of the fundraiser.', style: Theme.of(context).textTheme.bodyMedium, maxLines: 2),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 36.h),
                Divider(height: 1, color: R.palette.lightGray.withValues(alpha: 0.3)),
                SizedBox(height: 17.h),
                Center(
                  child: Container(
                    width: 154.w,
                    padding: EdgeInsets.symmetric(horizontal: 11.w, vertical: 5.h),
                    decoration: BoxDecoration(color: R.palette.green3, borderRadius: BorderRadius.circular(16.r)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(R.assets.graphics.svgIcons.protected, width: 15.w, height: 15.h),
                        SizedBox(width: 10.w),
                        Text('donation protected', style: Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 10.sp, color: R.palette.primary)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15.h),
                const FundraiserStoryCard(),
                SizedBox(height: 35.h),
                Padding(
                  padding: EdgeInsets.only(left: 27.w, right: 25.w),
                  child: Row(
                    children: [_buildDonateShareButton('Donate', context), SizedBox(width: 10.w), _buildDonateShareButton('Share', context)],
                  ),
                ),
                SizedBox(height: 100.h),
              ],
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      body: SlidingUpPanel(
        controller: _panelController,
        minHeight: 80.h,
        maxHeight: 220.h,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        panelBuilder: (scrollCam) => DonationPopupSheet(scrollCam: scrollCam, controller: _panelController),
        body: Background(safeAreaTop: true, child: body),
      ),
    );
  }
}

Widget _buildDonateShareButton(String title, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 54.w, vertical: 8.h),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.r), border: Border.all(color: R.palette.lightGray.withValues(alpha: 0.3),)),
    child: Text(title, style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600,height: 1.3.h)),
  );
}
