import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doneto/core/utils/go_router/app_routes.dart';
import 'package:doneto/core/utils/resource/r.dart';

class BottomSheets {
  static void openBottomSheet({
    required Widget widget,
    bool? isScrolled,
    double? borderRadius,
    Color? backgroundColor,
    bool? isDismissible,
    bool? enableDrag,
    int? startDuration,
    int? reverseDuration,
    BuildContext? context,
    double marginTop = 0,
  }) {
    showModalBottomSheet(
      isScrollControlled: isScrolled ?? false,
      enableDrag: enableDrag ?? true,
      isDismissible: isDismissible ?? true,
      context: context ?? AppRouter.rootNavigatorKey.currentState!.context,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(
          context ?? AppRouter.rootNavigatorKey.currentState!.context,
        ),
        duration: Duration(
          milliseconds: startDuration ?? 200,
        ),
        reverseDuration: Duration(
          milliseconds: reverseDuration ?? 200,
        ),
      ),
      backgroundColor: Colors.transparent,
      builder: (BuildContext ctx) {
        return Wrap(
          children: [
            Container(
              width: double.maxFinite,
              margin: EdgeInsets.only(top: marginTop.h),
              decoration: BoxDecoration(
                color: backgroundColor ?? R.palette.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(borderRadius ?? 25.r),
                  topRight: Radius.circular(
                    borderRadius ?? 25.r,
                  ),
                ),
              ),
              child: widget,
            )
          ],
        );
      },
    );
  }

  static void openBottomSheetWithoutWrapWidget({
    required Widget widget,
    bool? isScrolled,
    double? borderRadius,
    Color? backgroundColor,
    bool? isDismissible,
    bool? enableDrag,
    int? startDuration,
    int? reverseDuration,
    BuildContext? context,
    double marginTop = 0,
  }) {
    showModalBottomSheet(
      isScrollControlled: isScrolled ?? false,
      isDismissible: isDismissible ?? true,
      enableDrag: enableDrag ?? true,
      constraints: const BoxConstraints(minWidth: double.maxFinite),
      context: AppRouter.rootNavigatorKey.currentState!.context,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(
          AppRouter.rootNavigatorKey.currentState!.context,
        ),
        duration: Duration(
          milliseconds: startDuration ?? 200,
        ),
        reverseDuration: Duration(
          milliseconds: reverseDuration ?? 200,
        ),
      ),
      backgroundColor: backgroundColor,
      builder: (BuildContext ctx) {
        return Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: marginTop.h),
          decoration: BoxDecoration(
            color: R.palette.white  ,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(borderRadius ?? 25.r),
              topRight: Radius.circular(
                borderRadius ?? 25.r,
              ),
            ),
          ),
          child: widget,
        );
      },
    );
  }
}
