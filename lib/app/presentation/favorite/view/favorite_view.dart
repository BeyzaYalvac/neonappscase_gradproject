import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_assets.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

@RoutePage()
class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: AppMediaQuery.screenWidth(context),
              height: AppMediaQuery.screenHeight(context) * 0.65,

              decoration: BoxDecoration(
                color: AppColors.bgPrimary,
                borderRadius: BorderRadius.circular(16),
              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppPaddings.CustomHeightSizedBox(context, 0.08),
                  Lottie.asset(AppAssets.FAVORITE_ANIMATION),
                  Text(
                    AppStrings.FavoriteFileText,
                    style: AppTextSytlyes.favoriteFileTextStyle,
                  ),
                ],
              ),
            ).withPadding(EdgeInsets.all(16)),
          ],
        );
      },
    );
  }
}
