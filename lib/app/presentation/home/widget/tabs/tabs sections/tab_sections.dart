import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/view/favorite_view.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/tabs%20sections/home_tab.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/view/profile_view.dart';

class TabSections extends StatelessWidget {
  const TabSections({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final selected = state.selectedIndex;
    
        return IndexedStack(
          index: selected,
          children: const [HomeTab(), FavoriteView(), ProfileView()],
        );
      },
    );
  }
}