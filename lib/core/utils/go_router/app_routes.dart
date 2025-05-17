import 'package:doneto/core/utils/go_router/routes_constant.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/modules/auth/screens/create_profile.dart';
import 'package:doneto/modules/auth/screens/sign_in.dart';
import 'package:doneto/modules/auth/screens/sign_up.dart';
import 'package:doneto/modules/auth/screens/start_screen_index.dart';
import 'package:doneto/modules/bottom_tab/screens/bottom_tab.dart';
import 'package:doneto/modules/fundraiser/screens/doneto_verified_fundraisers.dart';
import 'package:doneto/modules/fundraiser/screens/explore_all_fundraisers.dart';
import 'package:doneto/modules/fundraiser/screens/fundraiser_index.dart';
import 'package:doneto/modules/fundraiser/screens/fundraiser_publish_response.dart';
import 'package:doneto/modules/fundraiser/screens/fundraising_index.dart';
import 'package:doneto/modules/fundraiser/screens/preview_fundraiser.dart';
import 'package:doneto/modules/onbording/screen/splash_index.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final rootNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        builder: (context, state) => const SplashIndex(),
        //
      ),
      GoRoute(
        path: Routes.createProfile,
        name: Routes.createProfile,
        builder: (context, state) => const CreateProfile(),
        //
      ),
      GoRoute(
        path: Routes.auth,
        name: Routes.auth,
        builder: (context, state) => const AuthIndex(),
        //
      ),
      GoRoute(
        path: Routes.fundraisingIndex,
        name: Routes.fundraisingIndex,
        builder: (context, state) => const FundraisingIndex(),
        //
      ),
      GoRoute(
        path: Routes.bottomTab,
        name: Routes.bottomTab,
        builder: (context, state) => const BottomTab(),
        //
      ),
      GoRoute(
        path: Routes.signIn,
        name: Routes.signIn,
        builder: (context, state) => const SignInIndex(),
        //
      ),
      GoRoute(
        path: Routes.fundraisingDetails,
        name: Routes.fundraisingDetails,
        builder: (context, state) => const FundraiserIndex(),
        //
      ),
      GoRoute(
        path: Routes.signUp,
        name: Routes.signUp,
        builder: (context, state) => const SignUpIndex(),
        //
      ),
      GoRoute(
        path: Routes.fundraiserPublishResponse,
        name: Routes.fundraiserPublishResponse,
        builder: (context, state) => const FundraiserPublishResponse(),
        //
      ),
      GoRoute(
        path: Routes.exploreAllFundraisers,
        name: Routes.exploreAllFundraisers,
        builder: (context, state) =>  const ExploreAllFundraisers(),
        //
      ),
      GoRoute(
        path: Routes.donetoVerifiedFundraisers,
        name: Routes.donetoVerifiedFundraisers,
        builder: (context, state) => const DonetoVerifiedFundraisers(),
        //
      ),
      GoRoute(
        path: Routes.previewFundraiser,
        name: Routes.previewFundraiser,
        builder:
            (context, state) => PreviewFundraiser(
              navigationData: state.extra as PreviewFundraiserNavigationData,
              //
            ),
      ),
    ],
    observers: [NavigationObserver()],
    errorBuilder: (context, state) => Routes.errorWidget(context, state),
  );

  static GoRouter get router => _router;
}
