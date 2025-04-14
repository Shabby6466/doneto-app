import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class MyLottieAnim extends StatelessWidget {
  final String path;
  final bool animate;
  final double width;
  final double height;

  const MyLottieAnim({
    super.key,
    required this.path,
    this.animate = true,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      path,
      animate: animate,
      width: width,
      height: height,
    );
  }
}
