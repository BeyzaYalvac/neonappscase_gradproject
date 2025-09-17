import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/favorite/cubit/favorite_state.dart';

class GridListCard extends StatelessWidget {
  final FileItem file;
  const GridListCard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        // Dosyanın favori olup olmadığını kontrol et
        final cubit = context.read<FavoriteCubit>();
        final key = file.link;
        final box = Hive.box('favorite_box');
        final isFavoriteFile = box.values.any(
          (v) => v is Map && v['type'] == 'file' && v['id'] == key,
        );

        return Card(
          elevation: 5,
          shadowColor: AppColors.bgTriartry,
          child: SizedBox(
            height: AppMediaQuery.screenHeight(context) * 0.25,
            width: AppMediaQuery.screenWidth(context) * 0.4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Stack(
                children: [
                  // ARKAPLAN (görsel ise resim; değilse gri alan + ikon)
                  Positioned.fill(
                    child: Image.network(
                      file.link,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.broken_image,
                            size: 50,
                            color: Colors.grey,
                          ),
                        );
                      },
                    ),
                  ),

                  // ALT SOL: İsim ve tarih
                  Positioned(
                    left: 8,
                    right: 8,
                    bottom: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          file.name
                              .replaceAll('&#40;', '(')
                              .replaceAll('&#41;', ')')
                              .replaceAll('&amp;', '&'),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Modified: ${file.uploaded}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: isFavoriteFile
                        ? Icon(Icons.star, color: AppColors.bgTriartry)
                        : Icon(Icons.star_border),
                    color: AppColors.bgTriartry,
                    onPressed: () {
                      if (isFavoriteFile) {
                        cubit.removeFavoriteFileByKey(file.link);
                      } else {
                        cubit.addFavoriteFile(file);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
