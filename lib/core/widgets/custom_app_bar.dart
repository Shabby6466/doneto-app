import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/back_arrow.dart';

// widget is used for custom app bar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.goBack,
    this.title = '',
    this.isLeading,
    this.backgroundColor,
    this.isEventAppBar,
    this.actions,
    this.onBackTap,
    this.isTrailing = false,
    this.doNotShowTitleIcon = false,
    this.percent = 0,
    this.shouldShowLinearIndicator = false,
  });

  final VoidCallback? goBack;
  final String title;
  final bool? isLeading;
  final Color? backgroundColor;
  final bool? isEventAppBar;
  final List<Widget>? actions;
  final bool isTrailing;
  final bool? doNotShowTitleIcon;
  final VoidCallback? onBackTap;
  final double percent;
  final bool shouldShowLinearIndicator;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BackArrow(
                iconColor: Theme.of(context).highlightColor,
                action: () {
                  if (onBackTap == null) {
                    if (sl<Navigation>().canPop()) {
                      sl<Navigation>().popFromRoute();
                    }
                  } else {
                    onBackTap!();
                  }
                },
              ),
              SizedBox(width: 8.w),
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                      ),
                ),
              ),
            ],
          ),
          actions: isTrailing == false ? [Container(width: 50.w, color: Theme.of(context).scaffoldBackgroundColor.withValues(alpha: .7))] : actions,
        ),
        if (shouldShowLinearIndicator) ...[
          Align(
            alignment: Alignment.center,
            child: LinearPercentIndicator(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              key: const ValueKey('linearPercentIndicator_key_1'),
              animation: false,
              lineHeight: 8.h,
              percent: percent,
              alignment: MainAxisAlignment.center,
              backgroundColor: R.palette.lightBorder,
              barRadius: Radius.circular(4.r),
              progressColor: R.palette.primaryLight,
            ),
          ),
        ]
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(76.h);
}
