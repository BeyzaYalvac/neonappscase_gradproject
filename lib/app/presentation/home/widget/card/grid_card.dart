import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list.dart';

class GridListCard extends StatelessWidget {
  final FileItem file;
  const GridListCard({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    print("file.link");
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

              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.bgTriartry.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    file.uploaded,
                    style: AppTextSytlyes.whiteTextStyle,
                  ),
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
            ],
          ),
        ),
      ),
    );
  }
}
