import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';

class ItemDetailListTile extends StatelessWidget {
  const ItemDetailListTile({
    super.key,
    required this.f,
    required this.item,
  });

  final FileFolderListModel f;
  final FileFolderListModel? item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: AppColors.bgTriartry,
      shape: BeveledRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
      leading: AppIcons.folder,
      title: Text(
        f.name,
        style: TextStyle(color: AppColors.textDark),
      ),
      onTap: () => context.pushRoute(
        ItemDetailRoute(
          item: f,
          oldFolderName: item?.name ?? "",
        ),
      ),
    );
  }
}
