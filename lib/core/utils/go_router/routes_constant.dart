import 'package:doneto/core/utils/go_router/not_found_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// this class is used for handling routes name
class Routes {
  /// Init routes
  static const splash = '/';
  static const auth = '/auth';
  static const intro = '/auth';

  static Widget errorWidget(BuildContext context, GoRouterState state) => const NotFoundScreen();
}
