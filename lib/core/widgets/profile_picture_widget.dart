import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/cache_network_image.dart';

class ProfilePictureWidget extends StatelessWidget {
  const ProfilePictureWidget({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
    required this.borderRadius,
    this.loading = false,
    this.localImg = false,
    this.errorImage = '',
  });

  final String imageUrl;
  final double height;
  final double width;
  final double borderRadius;
  final bool loading, localImg;
  final String errorImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: R.palette.primaryLight, width: 2.r),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: localImg && imageUrl.isNotEmpty
            ? Image.file(
                File(imageUrl),
                fit: BoxFit.cover,
                height: height,
                width: width,
              )
            : MyCachedNetworkImage(
                errorPadding: 12,
                imageUrl: imageUrl,
                imageFit: BoxFit.cover,
                height: height,
                width: width,
              ),
      ),
    );
  }
}
