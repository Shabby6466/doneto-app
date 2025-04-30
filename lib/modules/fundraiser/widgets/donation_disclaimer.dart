import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonationDisclaimer extends StatelessWidget {
  /// Called when the user taps “terms”
  final VoidCallback onTermsTap;

  /// Called when the user taps “privacy policy”
  final VoidCallback onPrivacyPolicyTap;

  /// Base font size
  final double fontSize;

  const DonationDisclaimer({super.key, required this.onTermsTap, required this.onPrivacyPolicyTap, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: RichText(
        textScaler: const TextScaler.linear(1.2),
        textAlign: TextAlign.center,
        text: TextSpan(
          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: R.palette.lightGray, fontSize: 10.sp, height: 1.5.h),
          children: [
            const TextSpan(text: 'Please keep in mind that transaction '),
            TextSpan(text: 'fees', style: Theme.of(context).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 10.sp, height: 1.h)),
            const TextSpan(text: ', including credit and debit charges, are deducted from each donation. By continuing, you agree to the doneto '),
            TextSpan(
              text: 'terms',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 10.sp, height: 1.h),
              recognizer: TapGestureRecognizer()..onTap = onTermsTap,
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'privacy policy',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(color: R.palette.primary, fontSize: 10.sp, height: 1.h),
              recognizer: TapGestureRecognizer()..onTap = onPrivacyPolicyTap,
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}
