import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';

class HomePageSummmaryData extends StatelessWidget {
  final AccountModel acountInfos;
  const HomePageSummmaryData({super.key, required this.acountInfos});

  double bytoToGb(int bytes) {
    return (bytes / (1024 * 1024 * 1024));
  }

  String _formatBytes(num bytes, [int decimals = 1]) {
    if (bytes <= 0) return '0 B';
    const k = 1024;
    const units = ['B', 'KB', 'MB', 'GB', 'TB', 'PB'];
    final i = (math.log(bytes) / math.log(k)).floor();
    final v = bytes / math.pow(k, i);
    return '${v.toStringAsFixed(decimals)} ${units[i]}';
  }

  @override
  Widget build(BuildContext context) {
    // Güvenli okuma

    final stats = acountInfos;
    print(stats);
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
      children: [
        Row(
          children: [
            const Icon(Icons.donut_large, color: AppColors.textBej, size: 8),
            AppPaddings.CustomWidthSizedBox(context, 0.01),

            Text(
              "Total ${storageCanUsed.toStringAsFixed(3)} GB",
              style: TextStyle(color: AppColors.textBej),
            ),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.donut_large, color: AppColors.textBej, size: 8),
            AppPaddings.CustomWidthSizedBox(context, 0.1),
            Text(
              'Used ${_formatBytes(storageBytes)}',
              style: TextStyle(color: AppColors.textWhite),
            ),
          ],
        ),
      ],
    );
  }
}
