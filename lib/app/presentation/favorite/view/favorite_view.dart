import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_assets.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
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

                          return ListTile(
                            leading: Icon(
                              isFolder ? Icons.folder : Icons.insert_drive_file,
                              color:
                                  Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.bgTriartry
                                  : AppColors.bgPrimary,
                            ),
                            title: Text(name),
                            trailing: IconButton(
                              icon: AppIcons.delete,
                              onPressed: () {
                                // fldId ile silmek istersemmm:
                                if (fav['id'] != null &&
                                    fav['type'] == 'folder') {
                                  context
                                      .read<FavoriteCubit>()
                                      .removeFavoriteFolder(fav['id']);
                                } else if (fav['type'] == 'file' &&
                                    fav['id'] != null) {
                                  context
                                      .read<FavoriteCubit>()
                                      .removeFavoriteFileByKey(fav['id']);
                                } else if (fav['type'] == 'image' &&
                                    fav['id'] != null) {
                                  context
                                      .read<FavoriteCubit>()
                                      .removeFavoriteImage(fav['id']);
                                }
                              },
                            ),
                          );
                        },
                      ),
              ).withPadding(const EdgeInsets.all(16)),
            ],
          ),
        );
      },
    );
  }
}

class FavoritesEmpty extends StatelessWidget {
  const FavoritesEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppPaddings.customHeightSizedBox(context, 0.08),
        Center(
          child: Transform.scale(
            scale: 4, // 1.0 = orijinal
            child: Lottie.asset(
              AppAssets.favoriteAnimation,
              width: AppMediaQuery.screenWidth(context) * 0.8,
              height: AppMediaQuery.screenWidth(context) * 0.8,
            ),
          ),
        ),
        Text(
          AppStrings.favoriteFileText,
          style: AppTextSytlyes.favoriteFileTextStyle,
        ),
      ],
    );
  }
}
