import 'package:doneto/core/di/di.dart';
import 'package:doneto/core/services/usecases/usecase.dart';
import 'package:doneto/core/utils/go_router/routes_navigation.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/fundraiser/usecases/watch_all_fundraisers.dart';
import 'package:doneto/modules/home/bloc/home_bloc.dart';
import 'package:doneto/modules/home/screens/home_search_screen.dart';
import 'package:doneto/modules/home/widgets/donation_cards_grid.dart';
import 'package:doneto/modules/home/widgets/search_bar.dart';
import 'package:doneto/modules/onbording/widgets/my_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExploreAllFundraisers extends StatefulWidget {
  const ExploreAllFundraisers({super.key});

  @override
  State<ExploreAllFundraisers> createState() => _ExploreAllFundraisersState();
}

class _ExploreAllFundraisersState extends State<ExploreAllFundraisers> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      builder: (context, state) {
        final stream = sl<WatchAllFundraisersUseCase>().calling(NoParams());
        return Background(
          safeAreaTop: true,
          child: Column(
            children: [
              MyTopBar(
                onTap: () {
                  if (sl<Navigation>().canPop()) sl<Navigation>().popFromRoute();
                },
                title: 'Explore all fundraisers',
              ),
              SizedBox(height: 30.h),
              CustomSearchBar(
                searchController: _searchController,
                onChanged: (e) {
                  if (e.trim().isEmpty) {
                    context.read<HomeBloc>().add(ClearSearchEvent());
                    context.read<HomeBloc>().add(LoadFundraisersEvent());
                    context.read<HomeBloc>().add(FeaturedFundraisersEvent());
                  } else {
                    context.read<HomeBloc>().add(SearchFundraisersEvent(query: e.trim()));
                  }
                },
                //
              ),
              if (state is SearchingState) ...[
                const Expanded(child: HomeSearchScreen()),
              ] else ...[
                SingleChildScrollView(child: DonationCardsGrid(fundraiserStream: stream)),
              ],
            ],
            //
          ),
          //
        );
      },
      listener: (ctx, state) {},
    );
  }
}
