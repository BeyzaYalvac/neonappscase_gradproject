import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';

class HomePageListLayoutTabFile extends StatelessWidget {
  final List<FileItem> filteredFiles;

  const HomePageListLayoutTabFile({super.key, required this.filteredFiles});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        final cubit = context.read<FavoriteCubit>();

        return ListView.builder(
          padding: EdgeInsets.symmetric(
            horizontal: AppMediaQuery.screenWidth(context) * 0.05,
          ),
          itemCount: filteredFiles.length,
          itemBuilder: (context, index) {
            final file = filteredFiles[index];
            final String fileKey = file.link; // ✅ benzersiz anahtar olarak link

            final bool isFavoriteFile = state.favoriteFolders.any(
          (fav) => fav['id'] == fileKey && fav['type'] == 'file',
        );
            return ListTile(
              leading: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: isFavoriteFile
                        ? Icon(Icons.star, color: AppColors.bgTriartry)
                        : Icon(Icons.star_border),

                    color: AppColors.bgTriartry,
                    onPressed: () {
                      if (isFavoriteFile) {
                        cubit.removeFavoriteFile(filteredFiles[index].link);
                      } else {
                        cubit.addFavoriteFile(filteredFiles[index]);
                      }
                    },
                  ),
                  const Icon(Icons.folder, color: AppColors.bgTriartry),
                ],
              ),
              title: Text(
                filteredFiles[index].name,
                style: TextStyle(
                  color: AppColors.bgTriartry,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text('Size: ${index * 10 + 5} MB'),
              trailing: Text('Modified: ${index + 1} days ago'),
            );
          },
        );
      },
    );
  }
}
