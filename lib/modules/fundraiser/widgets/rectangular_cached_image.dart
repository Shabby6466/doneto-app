import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doneto/core/utils/resource/r.dart';

class RectangularCacheNetworkImage extends StatelessWidget {
  /// Final uploaded image URL. If empty, shows the dashed-rectangle placeholder.
  final String imageUrl;

  /// Desired width & height of the card.
  final double width;
  final double height;

  /// Corner radius of the rectangle.
  final double borderRadius;

  /// Dash pattern for the placeholder border.
  final List<double> dashPattern;

  /// Border color when no image.
  final Color borderColor;

  /// Stroke width for the dashed border.
  final double strokeWidth;

  /// How to fit the image.
  final BoxFit fit;

  const RectangularCacheNetworkImage({
    super.key,
    required this.imageUrl,
    this.width = double.infinity,
    this.height = 180,
    this.borderRadius = 8,
    this.dashPattern = const [10, 5],
    this.borderColor = Colors.grey,
    this.strokeWidth = 1.5,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(borderRadius.r),
          color: borderColor,
          dashPattern: dashPattern,
          strokeWidth: strokeWidth,
          child: Container(
            width: width,
            height: height.h,
            alignment: Alignment.center,
            child: SvgPicture.asset(
              R.assets.graphics.svgIcons.cameraIcon,
              colorFilter: ColorFilter.mode(R.palette.primary, BlendMode.srcIn),
              width: 40.w,
              height: 40.h,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                insetPadding: EdgeInsets.all(10.r),
                contentPadding: EdgeInsets.zero,
                content: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius.r),
                  child: CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: fit,
                    width: double.infinity,
                    placeholder: (ctx, url) => SizedBox(height: height.h, width: width, child: const Center(child: CircularProgressIndicator.adaptive())),
                    errorWidget:
                        (ctx, url, error) => Container(
                          color: R.palette.lightGray,
                          height: height.h,
                          width: width,
                          alignment: Alignment.center,
                          child: SvgPicture.asset(R.assets.graphics.svgIcons.cameraIcon, height: 40.h, width: 40.w),
                        ),
                  ),
                ),
              ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: fit,
          width: width,
          height: height.h,
          placeholder: (ctx, url) => SizedBox(height: height.h, width: width, child: const Center(child: CircularProgressIndicator.adaptive())),
          errorWidget:
              (ctx, url, error) => Container(
                color: R.palette.lightGray,
                height: height.h,
                width: width,
                alignment: Alignment.center,
                child: SvgPicture.asset(R.assets.graphics.svgIcons.cameraIcon, height: 40.h, width: 40.w),
              ),
        ),
      ),
    );
  }
}
