import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
import 'package:neonappscase_gradproject/app/presentation/item_details/widget/container/item_detail_listbuilder.dart';
import 'package:neonappscase_gradproject/core/widget/appBar/custom_appbar.dart';

@RoutePage()
class ItemDetailView extends StatelessWidget implements AutoRouteWrapper {
  final FileFolderListModel? item;
  final String? oldFolderName;
  const ItemDetailView({super.key, this.item, this.oldFolderName});

  int _extractFolderId(dynamic fldId) {
    if (fldId is int) return fldId;
    if (fldId is String) return int.tryParse(fldId) ?? 0;
    return 0;
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final id = _extractFolderId(item?.fldId);

    return BlocProvider<HomeCubit>(
      create: (_) {
        final c = HomeCubit.forDetail();
        Future.microtask(() async {
          await c.getFoldersInFolder(id);
          await c.getFilesInFolder(id);
        });
        return c;
      },
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final folders = state.folders;
        final files = state.files;
        final total = folders.length + files.length;
        var currentFolderName = "${oldFolderName ?? ""}/${item!.name}/";
        return Scaffold(
          appBar: CustomAppBar(),
          body: SizedBox(
            width: AppMediaQuery.screenWidth(context),
            height: AppMediaQuery.screenHeight(context),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    currentFolderName,
                    style: AppTextSytlyes.whiteItemTextStyle,
                  ),

                  AppPaddings.customHeightSizedBox(context, 0.02),
                  Container(
                    width: AppMediaQuery.screenWidth(context) * 0.9,
                    height: AppMediaQuery.screenHeight(context) * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppPaddings.medium),
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.bgPrimary
                          : Colors.grey.shade600,
                    ),
                    child: ItemDetailListBuilder(
                      total: total,
                      folders: folders,
                      item: item,
                      files: files,
                      state: state,
                    ),
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
