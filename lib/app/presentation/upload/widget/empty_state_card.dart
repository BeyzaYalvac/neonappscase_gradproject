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
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class photoUploadColumn extends StatelessWidget {
  const photoUploadColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () => context.read<UploadCubit>().uploadImageFromGallery(),

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
                    AppStrings.uploadImageText,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color:
                          Theme.of(context).colorScheme.brightness ==
                              Brightness.light
                          ? AppColors.textMedium
                          : AppColors.textWhite,
                      fontSize: MediaQuery.textScaleFactorOf(context) * 16,
                    ),
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
              AppPaddings.CustomHeightSizedBox(context, 0.08),
              Lottie.asset(AppAssets.UPLOAD_ANIMATION),
              Text(
                AppStrings.uploadImageText,
                style: AppTextSytlyes.uploadFileTextStyle,
              ),
            ],
          ),
        ).withPadding(EdgeInsets.all(16)),
      ],
    );
  }
}
