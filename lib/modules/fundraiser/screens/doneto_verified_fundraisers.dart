import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/screens/doneto_verified_search_screen.dart';
import 'package:doneto/modules/home/bloc/home_bloc.dart';
import 'package:doneto/modules/home/widgets/donation_cards_grid.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DonetoVerifiedFundraisers extends StatefulWidget {
  const DonetoVerifiedFundraisers({super.key});

  @override
  State<DonetoVerifiedFundraisers> createState() => _DonetoVerifiedFundraisersState();
}

class _DonetoVerifiedFundraisersState extends State<DonetoVerifiedFundraisers> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(DonetoVerifiedFundraisersEvent());
    context.read<HomeBloc>().add(ClearSearchEvent());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (ctx, state) {
        // Handle any state changes here if needed
      },
      builder: (context, state) {
        return Background(
          safeAreaTop: true,
          child: Column(
            children: [
              MyTopBar(
                onTap: () {
                  if (sl<Navigation>().canPop()) sl<Navigation>().popFromRoute();
                },
                title: 'Doneto verified fundraisers',
              ),
              SizedBox(height: 30.h),
              // CustomSearchBar(
              //   searchController: _searchController,
              //   onChanged: (query) {
              //     if (query.trim().isEmpty) {
              //       // Clear search and ensure we're showing all verified fundraisers
              //       context.read<HomeBloc>().add(ClearSearchEvent());
              //       context.read<HomeBloc>().add(DonetoVerifiedFundraisersEvent());
              //     } else {
              //       // Trigger search for verified fundraisers
              //       context.read<HomeBloc>().add(DonetoVerifiedSearchEvent(query: query.trim()));
              //       // Enter search mode
              //       context.read<HomeBloc>().add(SearchingEvent());
              //     }
              //   },
              // ),
              if (state is SearchingState) ...[
                const Expanded(child: DonetoVerifiedSearchScreen()),
              ] else ...[
                Expanded(
                  child: SingleChildScrollView(
                    child: DonationCardsGrid(fundraiserStream: state.donetoVerifiedFundraisers,donetoVerified: true,)
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
