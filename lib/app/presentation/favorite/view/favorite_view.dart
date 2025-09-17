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

              child: state.favoriteFolders.isEmpty
                  ? const FavoritesEmpty()
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: state.favoriteFolders.length,
                      itemBuilder: (context, index) {
                        final fav =
                            state.favoriteFolders[index]
                                as Map; // <-- Map olarak al
                        final isFolder = fav['type'] == 'folder';
                        final name = (fav['name'] ?? '').toString();
                        final sizeText = (fav['size'] != null)
                            ? '${fav['size']} MB'
                            : '—';

                        return ListTile(
                          leading: Icon(
                            isFolder ? Icons.folder : Icons.insert_drive_file,
                            color: AppColors.bgTriartry,
                          ),
                          title: Text(name),
                          subtitle: Text('Size: $sizeText'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              // fldId ile silmek istersen:
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
            ),
          ],
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
        AppPaddings.CustomHeightSizedBox(context, 0.08),
        Lottie.asset(AppAssets.FAVORITE_ANIMATION),
        Text(
          AppStrings.FavoriteFileText,
          style: AppTextSytlyes.favoriteFileTextStyle,
        ),
      ],
    );
  }
}
