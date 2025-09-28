
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class StorageBar extends StatelessWidget {
  const StorageBar({
    super.key,
    required this.h,
    required this.w,
    required this.progress,
  });

  final double h;
  final double w;
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.10,
      width: w * 0.9,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.bgSmoothDark
            : AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.bgQuaternary),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Current Storage: ${progress.toStringAsFixed(4)}GB / 5GB ",
              style: AppTextSytlyes.currStorage(context)
            ),
            const SizedBox(height: AppPaddings.small),
            LinearProgressIndicator(
              minHeight: h * 0.02,
              value: progress,
              backgroundColor: AppColors.bgQuaternary,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.bgTriartry,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
