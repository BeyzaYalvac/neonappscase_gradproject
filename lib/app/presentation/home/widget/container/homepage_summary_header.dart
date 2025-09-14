import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';

class HomePageSummaryHeader extends StatelessWidget {
  final AccountModel accountInfos;

  const HomePageSummaryHeader({super.key, required this.accountInfos});
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
    final stats = accountInfos.statsCurrent;
    print(stats);
    final storageBytes = (stats.storage is num) ? (stats.storage as num) : 0;
    final usedBytes = storageBytes;
    debugPrint(storageBytes.toString());
    // Sabit kapasite örneği: 5 GB
    const totalBytes = 5 * 1024 * 1024 * 1024;
    final percent = usedBytes / totalBytes; // 0.0 ile 1.0 arası
    print((percent * 100).toStringAsFixed(8)); // yüzde formatı için

    final percentText = (percent).toStringAsFixed(8);
    return Column(
      children: [
        SizedBox(
          width: AppMediaQuery.screenWidth(context),
          height: AppMediaQuery.screenHeight(context) * 0.35,
          child: Center(
            child: SizedBox(
              width: AppMediaQuery.screenWidth(context) * 0.5,
              height: AppMediaQuery.screenWidth(context) * 0.5,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Boş daire
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: 1, // full circle background
                      strokeWidth: 12,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.bgQuaternary,
                      ),
                    ),
                  ),
                  // Kullanılan alan
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: percent,
                      strokeWidth: 12,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.bgPrimary,
                      ),
                    ),
                  ),
                  // Ortadaki yazılar
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${percentText}%',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textWhite,
                        ),
                      ),
                      Text(
                        'Used',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
