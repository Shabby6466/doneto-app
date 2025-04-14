import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/text_widget.dart';


// common widget for button
class MyButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool disableButton;
  final bool loading;
  final double horizontalMargin;
  final Color? bgColor;
  final Color? titleColor;
  final Color? borderColor;
  final bool enableBorder;
  final double height;
  final double width;
  final bool? isShowIcon;
  final String? assetName;
  final double borderRadius;
  final double titleSize;
  final Color? progressBarColor;
  final FontWeight? weight;

  const MyButton({
    super.key,
    this.disableButton = false,
    this.loading = false,
    required this.title,
    required this.onTap,
    this.bgColor,
    this.titleColor,
    this.borderColor,
    this.enableBorder = false,
    this.height = 48,
    this.width = 335,
    this.isShowIcon = false,
    this.assetName,
    this.weight,
    this.borderRadius = 10,
    this.titleSize = 16,
    this.horizontalMargin = 0,
    this.progressBarColor,
  });

  @override
  Widget build(BuildContext context) {
    // var themeMode = context.read<SettingBloc>().state.darkMode;
    return GestureDetector(
      onTap: disableButton || loading ? null : onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius.r),
          // color: getBgColor(themeMode, context),
        ),
        alignment: Alignment.center,
        child: loading
            ? SizedBox(
                key: const Key('circularIndicator'),
                height: 24.h,
                width: 24.w,
                child: CircularProgressIndicator(
                  color: progressBarColor ?? R.palette.white,
                  strokeWidth: 2.w,
                ),
              )
            : TextWidget(
                title,
                color: titleColor ?? R.palette.white,
                size: titleSize.sp,
                weight: weight ?? FontWeight.w400,
                // height: 1.4.h,
              ),
      ),
    );
  }

  Color getBgColor(bool themeMode, BuildContext context) {
    if (themeMode) {
      return disableButton ? R.palette.primaryLight.withValues(alpha: .5) : R.palette.primaryLight;
    }
    return disableButton ? R.palette.primaryLight.withValues(alpha: 0.5) : bgColor ?? R.palette.primaryLight;
  }
}

class MTB extends StatelessWidget {
  const MTB({super.key, required this.disable});

  final bool disable;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.maxFinite,
      height: 60.h,
      color: disable ? R.palette.disabledColor : R.palette.primary.withValues(alpha: .7),
      hoverColor: disable ? R.palette.disabledColor : R.palette.primary,
      onPressed: () {},
      elevation: disable ? 0 : 4.r,
      splashColor: disable ? R.palette.disabledColor : R.palette.primary.withValues(alpha: .7),
      disabledElevation: 0,
      hoverElevation: disable ? 0 : 4.r,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    required this.title,
    required this.onTap,
    this.radius = 10,
    this.width = 150,
    this.height = 55,
    this.titleSize = 16,
    this.weight,
    this.assetName = '',
    this.decoration,
  });

  final String title;
  final VoidCallback onTap;
  final double radius, width, height, titleSize;
  final FontWeight? weight;
  final String assetName;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    // var themeMode = context.read<SettingBloc>().state.darkMode;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          // color: getBgColor(themeMode, context),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: assetName.isNotEmpty,
              child: SvgPicture.asset(
                assetName,
                colorFilter: ColorFilter.mode(Theme.of(context).highlightColor, BlendMode.srcIn),
              ),
            ),
            TextWidget(
              title,
              size: titleSize.sp,
              color: R.palette.disabledColor,
              decoration: decoration,
              weight: weight,
            ),
          ],
        ),
      ),
    );
  }

  Color getBgColor(bool themeMode, BuildContext context) {
    return R.palette.transparent;
  }
}
