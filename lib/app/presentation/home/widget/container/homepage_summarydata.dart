import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';
import 'package:neonappscase_gradproject/app/presentation/home/widget/container/homepage_summary_data_Icon_text.dart';
import 'package:neonappscase_gradproject/core/utils/storage_utils.dart';

class HomePageSummmaryData extends StatelessWidget {
  final AccountModel acountInfos;
  const HomePageSummmaryData({super.key, required this.acountInfos});

  @override
  Widget build(BuildContext context) {
    final stats = acountInfos;
    //print(stats);
    final storageBytes = stats.storageUsed;
    final storageGb = StorageUtils.bytoToGb(storageBytes);
    final storageLeft = stats.storageLeft;
    final storageLeftGB = StorageUtils.bytoToGb(storageLeft);
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
            MainTotalIcon(),

            //AppPaddings.customWidthSizedBox(context, 0.001),
            MainTotalText(storageCanUsed: storageCanUsed),

            SizedBox(width: AppMediaQuery.screenWidth(context) * 0.15),

            MainUsedIcon(),

            MainUsedText(storageGb: storageGb),

            AppPaddings.customWidthSizedBox(context, 0.01),
          ],
        ),
      ],
    );
  }
}
