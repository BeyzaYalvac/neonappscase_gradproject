import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_assets.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/cubit/upload_cubit.dart';
import 'package:neonappscase_gradproject/app/presentation/upload/cubit/upload_state.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';
import 'package:neonappscase_gradproject/main.dart';

class UploadFileBody extends StatelessWidget {
  const UploadFileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadCubit, UploadState>(
      listener: (context, state) => {
        if (state.status == UploadStatus.success)
          {
            rootScaffoldMessengerKey.currentState?.showSnackBar(
              const SnackBar(content: Text('Dosya başarıyla yüklendi.')),
            ),

            context.read<UploadCubit>().resetStatus(),
          },
        if (state.status == UploadStatus.failure && state.error != null)
          {
            rootScaffoldMessengerKey.currentState?.showSnackBar(
              const SnackBar(content: Text('Dosya byüklenemedi!')),
            ),

            context.read<UploadCubit>().resetStatus(),
          },
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => context.read<UploadCubit>().uploadFile(),

            child:
                Container(
                  width: AppMediaQuery.screenWidth(context) * 1,
                  height: AppMediaQuery.screenHeight(context) * 0.05,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.brightness ==
                            Brightness.light
                        ? AppColors.bgPrimary
                        : Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      AppStrings.uploadFileText,
                      textAlign: TextAlign.center,
                      style: AppTextSytlyes().uploadFileTextStyle(context),
                    ),
                  ),
                ).withPadding(
                  EdgeInsets.symmetric(
                    horizontal: AppMediaQuery.screenWidth(context) * 0.1,
                  ),
                ),
          ),
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
                Lottie.asset(AppAssets.uploadFileAnimation),
                Text(
                  AppStrings.uploadFileText,
                  style: AppTextSytlyes.uploadFileTextStyle_1,
                ),
              ],
            ),
          ).withPadding(EdgeInsets.all(16)),
        ],
      ),
    );
  }
}
