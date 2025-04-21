import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeesNotice extends StatelessWidget {
  const FeesNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final greyStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Colors.grey[600], height: 1.h, fontSize: 10.sp);
    final linkStyle = greyStyle.copyWith(color: Colors.green);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          style: greyStyle,
          children: [
            const TextSpan(
              text:
              'Please keep in mind that transaction ',
            ),
            TextSpan(
              text: 'fees',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                },
            ),
            const TextSpan(
              text:
              ', including credit and debit charges, are deducted from each donation. By continuing, you agree to the doneto ',
            ),
            TextSpan(
              text: 'terms',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/terms');
                },
            ),
            const TextSpan(text: ' and '),
            TextSpan(
              text: 'privacy policy',
              style: linkStyle,
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.pushNamed(context, '/privacy');
                },
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}