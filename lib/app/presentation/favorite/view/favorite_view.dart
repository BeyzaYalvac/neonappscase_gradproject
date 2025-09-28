import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/widget/favorite_listile.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/widget/favorites_empty.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

@RoutePage()
class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return Container(
          width: AppMediaQuery.screenWidth(context),
          height: AppMediaQuery.screenHeight(context),
          color: Theme.of(context).brightness == Brightness.light
              ? AppColors.bgTriartry
              : Theme.of(context).colorScheme.surface,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppMediaQuery.screenWidth(context),
                height: AppMediaQuery.screenHeight(context) * 0.65,

                decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.light
                      ? AppColors.bgPrimary
                      : AppColors.bgSmoothDark,
                  borderRadius: BorderRadius.circular(16),
                ),

                child: state.favoriteFolders.isEmpty
                    ? const FavoritesEmpty()
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.favoriteFolders.length,
                        itemBuilder: (context, index) {
                          final fav = state.favoriteFolders[index] as Map;
                          final isFolder = fav['type'] == 'folder';
                          final name = (fav['name'] ?? '').toString();

                          return FavoriteListile(isFolder: isFolder, name: name, fav: fav);
                        },
                      ),
              ).withPadding(const EdgeInsets.all(AppPaddings.medium)),
            ],
          ),
        );
      },
    );
  }
}

