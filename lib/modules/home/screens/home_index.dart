import 'package:doneto/core/utils/resource/r.dart';
import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/home/bloc/home_bloc.dart';
import 'package:doneto/modules/home/screens/home_main_screen.dart';
import 'package:doneto/modules/home/screens/home_search_screen.dart';
import 'package:doneto/modules/home/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeIndex extends StatefulWidget {
  const HomeIndex({super.key});

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadFundraisersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Background(
          safeAreaTop: true,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Image.asset(
                    R.assets.graphics.pngIcons.donetoLogo,
                    width: 182.w,
                    //
                  ),
                ),
                CustomSearchBar(
                  searchController: _searchController,
                  onChanged: (e) {
                    if (e.trim().isEmpty) {
                      context.read<HomeBloc>().add(ClearSearchEvent());
                      context.read<HomeBloc>().add(LoadFundraisersEvent());
                    } else {
                      context.read<HomeBloc>().add(SearchFundraisersEvent(query: e.trim()));
                    }
                  },
                  //
                ),
                if (state is SearchingState) ...[
                  const HomeSearchScreen(),
                  //
                ] else ...[
                  const HomeMainScreen(),
                  //
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
