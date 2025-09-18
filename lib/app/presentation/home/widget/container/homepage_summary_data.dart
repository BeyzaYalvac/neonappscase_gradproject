import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';

class HomePageSummmaryData extends StatelessWidget {
  final AccountModel acountInfos;
  const HomePageSummmaryData({super.key, required this.acountInfos});

  double bytoToGb(int bytes) {
    return (bytes / (1024 * 1024 * 1024));
  }

  @override
  Widget build(BuildContext context) {

    final stats = acountInfos;
    print(stats);
    final storageUsed = stats.storageUsedFormatted;
    final storageLeft = stats.storageLeftFormatted;

    //debugPrint('ROOT keys: ${acountInfos.keys}');
    //debugPrint('data type : ${acountInfos['data']?.runtimeType}');
    //debugPrint('stats curr : ${acountInfos['data']?['statsCurrent']}');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.donut_large, color: AppColors.textBej, size: 8),
            AppPaddings.CustomWidthSizedBox(context, 0.01),

            Text(
              " Total $storageUsed",
              style: TextStyle(color: AppColors.textBej),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Icon(Icons.donut_large, color: AppColors.textBej, size: 8),
            AppPaddings.CustomWidthSizedBox(context, 0.1),
            Text(' Used  $storageUsed', style: AppTextSytlyes.whiteTextStyle),
          ],
        ),
      ],
    );
  }
}
