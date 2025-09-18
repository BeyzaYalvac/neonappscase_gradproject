import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/router/app_router.gr.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/file_folder_list_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/home/cubit/home_state.dart';
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
        final c =
            HomeCubit.forDetail(); // <-- Detay için sade kurucu (auto-load YOK)
        Future.microtask(() async {
          await c.getFoldersInFolder(id);
          await c.getFilesInFolder(id);
          // veya tek metot yazdıysan: await c.openFolder(id);
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
                  // başlık...
                  Text(
                    "$currentFolderName",
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  AppPaddings.CustomHeightSizedBox(context, 0.02),
                  Container(
                    width: AppMediaQuery.screenWidth(context) * 0.9,
                    height: AppMediaQuery.screenHeight(context) * 0.7,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.bgPrimary,
                    ),
                    child: Builder(
                      builder: (_) {
                        if (state.isLoading) {
                          return const Center(
                            child: CircularProgressIndicator(color: AppColors.textBej),
                          );
                        }
                        if (total == 0) {
                          return Center(
                            child: Text(
                             AppStrings.emptyFolderText,
                              style: TextStyle(color: AppColors.textDark),
                            ),
                          );
                        }

                        // Önce klasörler, sonra dosyalar
                        return ListView.separated(
                          itemCount: total,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 8),
                          itemBuilder: (context, index) {
                            if (index < folders.length) {
                              final f = folders[index];
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
                            } else {
                              final file = files[index - folders.length];
                              return ListTile(
                                tileColor: AppColors.bgTriartry,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(
                                    color: Colors.grey,
                                    width: 0.5,
                                  ),
                                ),
                                leading: Icon(
                                  Icons.insert_drive_file,
                                  color: AppColors.bgQuaternary,
                                ),
                                title: Text(
                                  file.name,
                                  style: TextStyle(color: AppColors.textDark),
                                ),
                              );
                            }
                          },
                        );
                      },
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
