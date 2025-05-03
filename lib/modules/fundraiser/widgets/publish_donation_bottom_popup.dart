import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class DonationPopupSheet extends StatelessWidget {
  final ScrollController scrollCam;
  final PanelController controller;

  const DonationPopupSheet({super.key, required this.scrollCam, required this.controller});

  // static const _donations = [
  //   {'name': 'faraz asad', 'amount': '500 PKR', 'label': 'Recent Donation'},
  //   {'name': 'faraz asad', 'amount': '50000 PKR', 'label': 'Top Donation'},
  //   {'name': 'faraz asad', 'amount': '250 PKR', 'label': 'First Donation'},
  // ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 12.h, bottom: 14.h),
          child: Column(
            children: [
              Container(width: 40.w, height: 4.h, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
              SizedBox(height: 8.h),
              Image.asset(R.assets.graphics.pngIcons.img, width: 100.w),
              SizedBox(height: 8.h),
              Text(
                'Every Rupee Counts',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 11.sp, color: R.palette.primary, fontWeight: FontWeight.w200),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: DonetoButton(
            title: 'Publish',
            onTap: () {
              sl<Navigation>().go(Routes.fundraiserPublishResponse);
            },
          ),
        ),
        SizedBox(height: 30.h),
      ],
    );
  }
}

// class _DonationTile extends StatelessWidget {
//   final String name, amount, label;
//
//   const _DonationTile({required this.name, required this.amount, required this.label});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         CircleAvatar(radius: 20.r, backgroundColor: Colors.grey[200], child: const Icon(Icons.person, color: Colors.grey)),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(name, style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600)),
//               SizedBox(height: 4.h),
//               Row(
//                 children: [
//                   Text(amount, style: Theme.of(context).textTheme.labelSmall!.copyWith(fontSize: 14.sp)),
//                   const SizedBox(width: 8),
//                   Text(
//                     label,
//                     style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 11.sp, fontWeight: FontWeight.w600, color: R.palette.primary),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
