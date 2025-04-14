import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doneto/core/utils/resource/r.dart';

class CircularCacheNetworkImage extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final String imageUrl;
  final String errorIconPath;
  final BoxFit imageFit;

  const CircularCacheNetworkImage({
    super.key,
    required this.size,
    required this.backgroundColor,
    required this.imageUrl,
    required this.errorIconPath,
    this.imageFit = BoxFit.cover,
  });

  bool get _isNetworkImage => imageUrl.startsWith('http');

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        width: 150.w,
        height: 150.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: R.palette.lightBorder,
            width: 2.w,
          ),
        ),
        child: ClipOval(
          child: Image.asset(
            R.assets.graphics.pngIcons.img,
            width: 30.w,
            height: 30.h,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget image;

    if (_isNetworkImage) {
      image = CachedNetworkImage(
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: imageProvider,
              fit: imageFit,
            ),
          ),
        ),
        progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator.adaptive(
            value: downloadProgress.progress,
          ),
        ),
        errorWidget: (context, url, error) => SizedBox(
          height: size,
          width: size,
          child: SvgPicture.asset(errorIconPath),
        ),
      );
    } else {
      image = Image.file(
        File(imageUrl),
        fit: imageFit,
        height: size,
        width: size,
        errorBuilder: (context, error, stackTrace) => SvgPicture.asset(errorIconPath),
      );
    }

    return SizedBox(
      height: size,
      width: size,
      child: CircleAvatar(
        backgroundColor: backgroundColor,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: image,
        ),
      ),
    );
  }
}

class MyCachedNetworkImage extends StatelessWidget {
  const MyCachedNetworkImage({
    super.key,
    this.height,
    this.width,
    this.backgroundColor,
    required this.imageUrl,
    this.imageFit,
    this.errorPadding = 0,
    this.radius = 0,
  });

  final double? height, width;
  final Color? backgroundColor;
  final String imageUrl;
  final BoxFit? imageFit;
  final double errorPadding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (imageUrl.isEmpty) {
      return Container(
        color: backgroundColor,
        height: height,
        width: width,
        padding: EdgeInsets.all(errorPadding.r),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius.r),
          child: Image.asset(
            R.assets.graphics.pngIcons.img,
            height: height,
            width: width,
            fit: imageFit,
          ),
        ),
      );
    }
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              insetPadding: EdgeInsets.all(10.r),
              contentPadding: EdgeInsets.zero,
              content: ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: imageFit,
                  progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                    height: height,
                    width: width,
                    child: Center(
                      child: CircularProgressIndicator.adaptive(
                        value: downloadProgress.progress,
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: backgroundColor,
                    height: height,
                    width: width,
                    padding: EdgeInsets.all(errorPadding.r),
                    child: Image.asset(
                      R.assets.graphics.pngIcons.img,
                      height: height,
                      width: width,
                      fit: imageFit,
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius.r),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: imageFit,
          height: height,
          width: width,
          cacheKey: imageUrl,
          fadeInCurve: Curves.linear,
          progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
            height: height,
            width: width,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius.r),
                child: Image.asset(
                  R.assets.graphics.pngIcons.img,
                  height: height,
                  width: width,
                  fit: imageFit,
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => Container(
            color: backgroundColor,
            height: height,
            width: width,
            padding: EdgeInsets.all(errorPadding.r),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius.r),
              child: Image.asset(
                R.assets.graphics.pngIcons.img,
                height: height,
                width: width,
                fit: imageFit,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
