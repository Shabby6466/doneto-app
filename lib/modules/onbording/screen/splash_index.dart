import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/auth/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashIndex extends StatefulWidget {
  const SplashIndex({super.key});

  @override
  State<SplashIndex> createState() => _SplashIndexState();
}

class _SplashIndexState extends State<SplashIndex> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(GetTokenEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc,AuthState>(
      listener: (context, state) {
        if (state is TokenFoundState) {
          sl<Navigation>().go(Routes.bottomTab);
          context.read<AuthBloc>().add(GetUserProfileEvent());
        }
        if (state is TokenNotFoundState) {
          sl<Navigation>().go(Routes.auth);
        }
      },
      builder: (context, state) {
        return Background(
          bgColor: R.palette.primary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 70.w),
                child: Center(child: Image.asset(height: 108.h, width: 262.w, R.assets.graphics.pngIcons.donetoWhiteLogo)),
              ),
              const Spacer(),
              Image.asset(R.assets.graphics.pngIcons.flowers),
            ],
          ),
        );
      },
    );
  }
}
