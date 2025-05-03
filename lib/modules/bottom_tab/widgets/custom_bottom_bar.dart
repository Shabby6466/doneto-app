import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomBar extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemTapped;

  const CustomBottomBar({super.key, required this.selectedIndex, required this.onItemTapped});

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  static final List<String> _icons = [
    R.assets.graphics.svgIcons.homeIcon,
    R.assets.graphics.svgIcons.exploreIcon,
    R.assets.graphics.svgIcons.sendIcon,
    R.assets.graphics.svgIcons.profileIcon,
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20.w, top: 4.h, right: 20.w, bottom: 14.h),
      width: 375.w,
      height: 75.h,
      decoration: BoxDecoration(
        color: R.palette.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: .1), spreadRadius: 1, blurRadius: 5, offset: const Offset(0, 2))],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(4, (index) {
          return BottomNavItem(
            index: index,
            iconPath: _icons[index],
            isSelected: widget.selectedIndex == index,
            onTap: () => widget.onItemTapped(index),
          );
        }),
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final int index;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavItem({super.key, required this.index, required this.iconPath, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            width: 46.w,
            color: R.palette.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset(
                    iconPath,
                    height: 24.h,
                    width: 24.w,
                    colorFilter: ColorFilter.mode(isSelected ? R.palette.primaryLight : R.palette.disabledText, BlendMode.srcATop),
                  ),
                  SizedBox(height: 5.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
