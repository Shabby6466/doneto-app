import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';

class FundraiserIndex extends StatefulWidget {
  const FundraiserIndex({super.key});

  @override
  State<FundraiserIndex> createState() => _FundraiserIndexState();
}

class _FundraiserIndexState extends State<FundraiserIndex> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        children: [
          MyTopBar(onTap: () {}, title: ''),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                // context.read<OnboardingBloc>().add(UpdatePageEvent(page: index));
              },
              children: [],
            ),
          ),
        ],
      ),
    );
  }
}
