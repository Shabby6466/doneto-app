import 'package:doneto/core/utils/go_router/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// this class is used for handling routes name
class Routes {
  /// Init routes
  static const splash = '/';
  static const auth = '/auth';
  static const intro = '/auth';
  static const fundraisingIndex = '/fundraising_index';
  static const fundraisingDetails = '/fundraising_details';
  static const signIn = '/sign_in';
  static const signUp = '/sign_up';
  static const bottomTab = '/bottom_tab';
  static const createProfile = '/create_profile';
  static const fundraiserPublishResponse = '/fundraiser_publish_response';
  static const exploreAllFundraisers = '/explore_all_fundraisers';
  static const donetoVerifiedFundraisers = '/doneto_verified_fundraisers';
  static const previewFundraiser = '/preview_fundraiser';

  static Widget errorWidget(BuildContext context, GoRouterState state) => const NotFoundScreen();
}
