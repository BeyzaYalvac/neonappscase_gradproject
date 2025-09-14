import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_paddings.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/core/extensions/widget_extensions.dart';

class GridFolderCard extends StatelessWidget {
  final String folderName;
  const GridFolderCard({super.key, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: true,
      elevation: 5,
      shadowColor: AppColors.bgTriartry,
      child: Stack(
        children: [
          Container(
            height: AppMediaQuery.screenHeight(context) * 0.11,
            width: AppMediaQuery.screenWidth(context) * 0.5,
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.bgTriartry, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Icon(Icons.folder, size: 50, color: AppColors.bgTriartry),
          ),

          Container(
            color: AppColors.bgTransparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: AppMediaQuery.screenWidth(context) * 0.12,
                  decoration: BoxDecoration(
                    color: AppColors.bgTriartry.withValues(alpha: 0.7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '5 MB',
                        style: TextStyle(color: AppColors.textWhite),
                      ),
                    ],
                  ),
                ).withAlignment(Alignment.topRight),
                AppPaddings.CustomHeightSizedBox(context, 0.072),
                Text(folderName, style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Modified: 15 days ago'),
              ],
            ).withPadding(const EdgeInsets.fromLTRB(8, 4, 8, 1)),
          ),
        ],
      ),
    );
  }
}
