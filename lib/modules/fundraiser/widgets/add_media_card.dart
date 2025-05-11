import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/modules/fundraiser/bloc/fundraiser_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class AddMediaCard extends StatelessWidget {
  /// Called when the user taps the card
  final VoidCallback? onTap;

  /// Text shown in the bottom-right
  final String label;

  /// Border radius
  final double borderRadius;

  /// Dash pattern: [dashLength, gapLength]
  final List<double> dashPattern;

  /// Height of the card
  final double height;

  const AddMediaCard({
    super.key,
    this.onTap,
    this.label = 'Add photo or video',
    this.borderRadius = 6,
    this.dashPattern = const [10, 5],

    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FundraiserBloc, FundraiserState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final picked = await picker.pickImage(source: ImageSource.gallery);
            if (picked == null) return;

            final file = File(picked.path);

            final cloudinary = sl<CloudinaryPublic>();

            final res = await cloudinary.uploadFile(
              CloudinaryFile.fromFile(file.path, folder: 'doneto', resourceType: CloudinaryResourceType.Image),
              //
            );
            final secureUrl = res.secureUrl;

            if (context.mounted) {
              context.read<FundraiserBloc>().add(FundraiserMediaUploadedEvent(mediaUrl: secureUrl));
            }
          },
          child: Padding(
            padding: EdgeInsets.only(left: 18.w, right: 18.w),
            child: DottedBorder(
              borderType: BorderType.RRect,
              color: R.palette.gray,
              dashPattern: dashPattern,
              radius: Radius.circular(borderRadius),
              strokeWidth: 1.5,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  height: height,
                  width: double.infinity,
                  alignment: Alignment.center,
                  child:
                      state.imageUrl.isEmpty
                          ? Stack(
                            children: [
                              SvgPicture.asset(
                                R.assets.graphics.svgIcons.cameraIcon,
                                colorFilter: ColorFilter.mode(
                                  R.palette.primary,
                                  BlendMode.srcIn,
                                  //
                                ),
                              ),
                            ],
                          )
                          : CachedNetworkImage(
                            imageUrl: state.imageUrl,
                            imageBuilder:
                                (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.fill,
                                      //
                                    ),
                                  ),
                                ),
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) => SizedBox(
                                  child: CircularProgressIndicator.adaptive(
                                    value: downloadProgress.progress,
                                    //
                                  ),
                                ),
                            errorWidget:
                                (context, url, error) => SizedBox(
                                  child: SvgPicture.asset(
                                    R.assets.graphics.svgIcons.cameraIcon,
                                    //
                                  ),
                                ),
                            //
                          ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
