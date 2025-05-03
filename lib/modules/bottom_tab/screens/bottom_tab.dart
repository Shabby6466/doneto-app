import 'package:doneto/core/widgets/base_widget.dart';
import 'package:doneto/modules/bottom_tab/bloc/bottom_tab_bloc.dart';
import 'package:doneto/modules/bottom_tab/widgets/custom_bottom_bar.dart';
import 'package:doneto/modules/explore/screens/explore_index.dart';
import 'package:doneto/modules/home/screens/home_index.dart';
import 'package:doneto/modules/profile/screens/profile_index.dart';
import 'package:doneto/modules/sending/screens/send_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomTab extends StatefulWidget {
  const BottomTab({super.key});

  @override
  State<BottomTab> createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BottomTabBloc, BottomTabState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Background(
          resizeToAvoidBottomInset: true,
          bottomNavigationBar: CustomBottomBar(
            selectedIndex: state.index,
            onItemTapped: (index) {
              context.read<BottomTabBloc>().add(ChangeBottomTabIndexEvent(index: index));
            },
          ),
          child: getChild(state.index),
        );
      },
    );
  }

  Widget getChild(int index) {
    switch (index) {
      case 0:
        return const HomeIndex();
      case 1:
        return const ExploreIndex();
      case 2:
        return const SendIndex();
      case 3:
        return const ProfileIndex();
      default:
        return const HomeIndex();
    }
  }
}
