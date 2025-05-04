import 'package:doneto/core/utils/resource/r.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 27.w, right: 28.w),
      child: Container(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        height: 48.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(32.r), color: R.palette.gray.withValues(alpha: 0.4)),
        child: Row(
          children: [
            SvgPicture.asset(R.assets.graphics.svgIcons.searchIcon),
            SizedBox(width: 10.w),
            Expanded(
              child: TextFormField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search fundraisers',
                  hintStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 16.sp / 14.sp,
                    color: R.palette.disabledText,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
