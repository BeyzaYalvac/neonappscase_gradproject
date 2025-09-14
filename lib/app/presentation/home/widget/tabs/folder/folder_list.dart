import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/spacing/app_mediaqueries.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/content_model.dart';

class HomePageFolderListLayoutTabFolder extends StatelessWidget {
  final List<ContentModel> filteredFolders;
  const HomePageFolderListLayoutTabFolder({
    super.key,
    required this.filteredFolders,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: AppMediaQuery.screenWidth(context) * 0.05,
      ),
      itemCount: filteredFolders.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.folder, color: AppColors.bgTriartry),
          title: Text(
            filteredFolders[index].name,
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
