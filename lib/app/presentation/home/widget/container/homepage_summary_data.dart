import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
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
    //print(stats);
    final storageBytes = stats.storageUsed;
    final storageGb = bytoToGb(storageBytes);
    final storageLeft = stats.storageLeft;
    final storageLeftGB = bytoToGb(storageLeft);
    final storageCanUsed = storageGb + storageLeftGB;

    //debugPrint('ROOT keys: ${acountInfos.keys}');
    //debugPrint('data type : ${acountInfos['data']?.runtimeType}');
    //debugPrint('stats curr : ${acountInfos['data']?['statsCurrent']}');

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Icon(
              Icons.donut_large,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.bgfourtary
                  : AppColors.bgSecondary,
              size: 16,
            ),
            AppPaddings.CustomWidthSizedBox(context, 0.01),

            Text(
              " Total ${storageCanUsed.toStringAsFixed(3)} GB",
              style: AppTextSytlyes.primaryColorTextStyle,
            ),
            SizedBox(width: AppMediaQuery.screenWidth(context) * 0.27),
            Icon(
              Icons.donut_large,
              color: Theme.of(context).brightness == Brightness.light
                  ? AppColors.bgSmoothLight
                  : AppColors.bgQuaternary,
              size: 16,
            ),
            Text(
              ' Used  ${storageGb.toStringAsFixed(3)} GB',
              style: AppTextSytlyes.primaryColorTextStyle,
            ),
            AppPaddings.CustomWidthSizedBox(context, 0.01),
          ],
        ),
      ],
    );
  }
}
