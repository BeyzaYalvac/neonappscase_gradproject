import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_strings.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';

class HomePageSummaryHeader extends StatelessWidget {
  final AccountModel accountInfos;

  const HomePageSummaryHeader({super.key, required this.accountInfos});

  @override
  Widget build(BuildContext context) {
    final stats = accountInfos;
    print(stats);
    // ignore: dead_code, unnecessary_type_check
    final storageBytes = (stats.storageUsed is num)
        ? (stats.storageUsed as num)
        : 0;
    final usedBytes = storageBytes;
    debugPrint(storageBytes.toString());
    // Sabit kapasite örneği: 5 GB
    const totalBytes = 5 * 1024 * 1024 * 1024;
    final percent = usedBytes / totalBytes; // 0.0 ile 1.0 arası
    print((percent * 100).toStringAsFixed(8)); // yüzde formatı için

    final percentText = (percent).toStringAsFixed(4);
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
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: 1,
                      strokeWidth: 16,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.bgTriartry,
                      ),
                    ),
                  ),
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: percent,
                      strokeWidth: 16,
                      backgroundColor: Colors.transparent,
                      valueColor: const AlwaysStoppedAnimation(
                        AppColors.bgSmoothLight,
                      ),
                    ),
                  ),
                  // Ortadaki yazılar
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$percentText%',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.textWhite
                              : AppColors.textMedium,
                        ),
                      ),
                      Text(
                        AppStrings.usedText,
                        style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppColors.textWhite
                              : AppColors.textMedium,
                        ),
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
