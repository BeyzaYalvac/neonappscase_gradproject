import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class HomePageFolderListLayoutTabFolder extends StatelessWidget {
  const HomePageFolderListLayoutTabFolder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppMediaQuery.screenWidth(context) * 0.05,
      ),
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.folder, color: AppColors.bgTriartry),
          title: Text(
            'Folder ${index + 1}',
            style: TextStyle(
              color: AppColors.bgTriartry,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text('Size: ${index * 10 + 5} MB'),
          trailing: Text('Modified: ${index + 1} days ago'),
        );
      },
    );
  }
}
