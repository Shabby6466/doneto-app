import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
class DonetoVerifiedFundraisers extends StatefulWidget {
  const DonetoVerifiedFundraisers({super.key});

  @override
  State<DonetoVerifiedFundraisers> createState() => _DonetoVerifiedFundraisersState();
}

class _DonetoVerifiedFundraisersState extends State<DonetoVerifiedFundraisers> {
  @override
  Widget build(BuildContext context) {
    return Background(
      safeAreaTop: true,
      child: Column(
        children: [
          MyTopBar(
            onTap: () {
              if (sl<Navigation>().canPop()) sl<Navigation>().popFromRoute();
            },
            title: 'Deonto verified fundraisers',
          ),
        ],
        //
      ),
      //
    );
  }
}
