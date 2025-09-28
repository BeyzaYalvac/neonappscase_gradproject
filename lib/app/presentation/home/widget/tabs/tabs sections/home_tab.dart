import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/tabs/tabs%20sections/homepage_body.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final account = state.acountInfos;
        if (account == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.bgTriartry),
          );
        }
        return HomePageBody(isGrid: state.isGridView, acountData: account);
      },
    );
  }
}

