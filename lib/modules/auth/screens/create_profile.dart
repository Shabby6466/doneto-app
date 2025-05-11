import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/core/widgets/cache_network_image.dart';
import 'package:doneto/core/widgets/custom_textfield.dart';
import 'package:doneto/modules/auth/bloc/auth_bloc.dart';
import 'package:doneto/modules/fundraiser/bloc/fundraiser_bloc.dart';
import 'package:doneto/modules/fundraiser/widgets/doneto_button.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FundraiserBloc, FundraiserState>(
      listener: (context, state) {
        if (state is CreateProfileSuccessState) {
          context.read<AuthBloc>().add(GetUserProfileEvent());
          sl<Navigation>().go(Routes.bottomTab);
        }
      },
      builder: (context, state) {
        return Background(
          resizeToAvoidBottomInset: true,
          bgColor: R.palette.secondary,
          safeAreaTop: true,
          child: SingleChildScrollView(
            child: Column(
              children: [
                MyTopBar(showBackBtn: false, onTap: () {}, title: 'Create Profile'),
                SizedBox(height: 58.h),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircularCacheNetworkImage(
                      size: 150.h,
                      backgroundColor: R.palette.white,
                      imageUrl: state.imageUrl,
                      errorIconPath: R.assets.graphics.svgIcons.cameraIcon,
                    ),
                    Positioned(
                      right: 8.w,
                      bottom: 8.h,
                      child: Container(
                        padding: EdgeInsets.all(5.r),
                        height: 35.h,
                        width: 35.w,
                        decoration: BoxDecoration(color: R.palette.white, shape: BoxShape.circle),
                        child: GestureDetector(
                          onTap: () async {
                            final picker = sl<ImagePicker>();
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
                          child: SvgPicture.asset(R.assets.graphics.svgIcons.cameraIcon),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 51.84.h),
                Padding(
                  padding: EdgeInsets.only(left: 51.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Profile Name',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
                    ),
                  ),
                ),
                SizedBox(height: 13.h),
                Padding(
                  padding: EdgeInsets.only(left: 51.w, right: 63.w),
                  child: MaterialTextFormField(
                    controller: _nameController,
                    labelText: 'Name of profile',
                    errorText: '',
                    onChange: (e) {
                      context.read<FundraiserBloc>().add(ProfileNameChangeEvent(profile: e));
                    },
                    //
                  ),
                ),
                SizedBox(height: 13.h),
                Padding(
                  padding: EdgeInsets.only(left: 51.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Phone',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
                    ),
                  ),
                ),
                SizedBox(height: 13.h),
                Padding(
                  padding: EdgeInsets.only(left: 51.w, right: 63.w),
                  child: MaterialTextFormField(
                    controller: _phoneController,
                    labelText: 'Phone number',
                    errorText: '',
                    onChange: (e) {
                      context.read<FundraiserBloc>().add(PhoneNumberChangeEvent(phoneNumber: e));
                    },
                    //
                  ),
                ),
                SizedBox(height: 13.h),
                Padding(
                  padding: EdgeInsets.only(left: 51.w),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Instagram',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge!.copyWith(color: R.palette.lightGray, fontSize: 16.sp, fontWeight: FontWeight.w400, height: 1.h),
                    ),
                  ),
                ),
                SizedBox(height: 13.h),
                Padding(
                  padding: EdgeInsets.only(left: 51.w, right: 63.w),
                  child: MaterialTextFormField(
                    controller: _instagramController,
                    labelText: 'Instagram handle link',
                    errorText: '',
                    onChange: (e) {
                      context.read<FundraiserBloc>().add(InstagramLinkChangeEvent(instaLink: e));
                    },
                    //
                  ),
                ),
                SizedBox(height: 150.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50.w),
                  child: DonetoButton(
                    onTap: () {
                      context.read<FundraiserBloc>().add(CreateUserProfileEvent());
                    },
                    loading: state.loading,
                    title: 'Create profile',
                  ),
                ),
                SizedBox(height: 37.h),
              ],
            ),
          ),
        );
      },
    );
  }
}
