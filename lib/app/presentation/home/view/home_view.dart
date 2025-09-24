import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/banner/network_materialBanner.dart';
import 'package:neonappscase_gradproject/core/widget/appBar/custom_appbar.dart';
import 'package:neonappscase_gradproject/core/widget/fab/action_fabs.dart';
import 'package:neonappscase_gradproject/core/widget/navbar/bottom_navbar.dart';

@RoutePage()
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? AppColors.bgPrimary
          : AppColors.bgSmoothDark,
      appBar: const CustomAppBar(),

      body: NetworkControlMaterialBanner(),

      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: AnimatedFloatingActionButton(),

      bottomNavigationBar: CurvedBottomNavBar(),
    );
  }
}
