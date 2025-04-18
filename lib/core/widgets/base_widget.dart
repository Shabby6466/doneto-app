import 'package:flutter/material.dart';
import 'package:doneto/core/utils/resource/r.dart';

class Background extends StatelessWidget {
  const Background({
    super.key,
    this.bgColor,
    this.appBar,
    this.scafoldKey,
    this.resizeToAvoidBottomInset,
    required this.child,
    this.bottomNavigationBar,
    this.isShowLoading = false,
    this.safeAreaTop = false,
  });

  final Color? bgColor;
  final PreferredSizeWidget? appBar;
  final Widget child;
  final GlobalKey<ScaffoldState>? scafoldKey;
  final bool? resizeToAvoidBottomInset;
  final Widget? bottomNavigationBar;
  final bool isShowLoading;
  final bool? safeAreaTop;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scafoldKey,
      bottomNavigationBar: bottomNavigationBar,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset ?? true,
      backgroundColor: bgColor ?? R.palette.secondary,
      appBar: appBar,
      body: safeAreaTop != null
          ? SafeArea(
              top: safeAreaTop!,
              bottom: false,
              child: child,
            )
          : child,
    );
  }
}
