import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/item_details/widget/listile/item_detail_listile.dart';

class ItemDetailListView extends StatelessWidget {
  const ItemDetailListView({
    super.key,
    required this.total,
    required this.folders,
    required this.item,
    required this.files,
  });

  final int total;
  final List<FileFolderListModel> folders;
  final FileFolderListModel? item;
  final List<FileItem> files;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: total,
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        if (index < folders.length) {
          final f = folders[index];
          return ItemDetailListTile(f: f, item: item);
        } else {
          final file = files[index - folders.length];
          return ListTile(
            tileColor: AppColors.bgTriartry,
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(
                color: AppColors.bgSmoothLight,
                width: 0.5,
              ),
            ),
            leading: Icon(
              Icons.insert_drive_file,
              color: AppColors.bgQuaternary,
            ),
            title: Text(file.name, style: AppTextSytlyes.darkTextStyle),
          );
        }
      },
    );
  }
}
