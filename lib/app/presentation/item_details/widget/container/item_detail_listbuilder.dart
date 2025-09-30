import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/item_details/widget/listView/item_detail_listview.dart';

class ItemDetailListBuilder extends StatelessWidget {
  const ItemDetailListBuilder({
    super.key,
    required this.total,
    required this.folders,
    required this.item,
    required this.files,
    required this.state,
  });

  final int total;
  final List<FileFolderListModel> folders;
  final FileFolderListModel? item;
  final List<FileItem> files;
  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (_) {
        if (state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.bgTriartry,
            ),
          );
        }
        if (total == 0) {
          return Center(
            child: Text(
              AppStrings.emptyFolderText,
              style: AppTextSytlyes.darkTextStyle,
            ),
          );
        }
    
        // Önce klasörler, sonra dosyalar
        return ItemDetailListView(
          total: total,
          folders: folders,
          item: item,
          files: files,
        );
      },
    );
  }
}
