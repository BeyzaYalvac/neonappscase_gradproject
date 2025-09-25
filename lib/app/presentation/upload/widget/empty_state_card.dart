import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_assets.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/injections/injection_container.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/cubit/upload_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/cubit/upload_state.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class PhotoUploadColumn extends StatelessWidget {
  const PhotoUploadColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UploadCubit, UploadState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) async {
        if (state.status == UploadStatus.success) {
          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: const Text('Yükleme tamamlandı'),
              content: const Text('Dosya başarıyla yüklendi.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Tamam'),
                ),
              ],
            ),
          );
          InjectionContainer.read<UploadCubit>().resetStatus();
        }

        if (state.status == UploadStatus.failure && state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Yükleme hatası: ${state.error}')),
          );
          InjectionContainer.read<UploadCubit>().resetStatus();
        }
      },

      builder: (context, state) {
        final cubit = context.read<UploadCubit>();

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Yükle butonu
            GestureDetector(
              onTap: () => cubit.uploadImageFromGallery(),
              child:
                  Container(
                    width: AppMediaQuery.screenWidth(context),
                    height: AppMediaQuery.screenHeight(context) * 0.05,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                          ? AppColors.bgPrimary
                          : Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.uploadImageText,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? AppColors.textMedium
                              : AppColors.textWhite,
                          fontSize: AppMediaQuery.screenWidth(context) * 0.06,
                        ),
                      ),
                    ),
                  ).withPadding(
                    EdgeInsets.symmetric(
                      horizontal: AppMediaQuery.screenWidth(context) * 0.1,
                    ),
                  ),
            ),

            if (state.status == UploadStatus.uploading)
              const LinearProgressIndicator().withPadding(
                const EdgeInsets.all(16),
              ),

            // Görsel alan
            Container(
              width: AppMediaQuery.screenWidth(context),
              height: AppMediaQuery.screenHeight(context) * 0.65,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.bgPrimary
                    : Colors.grey,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppPaddings.customHeightSizedBox(context, 0.08),
                  Lottie.asset(AppAssets.uploadAnimation),
                  Text(
                    AppStrings.uploadImageText,
                    style: AppTextSytlyes.uploadFileTextStyle,
                  ),
                ],
              ),
            ).withPadding(const EdgeInsets.all(16)),
          ],
        );
      },
    );
  }
}
