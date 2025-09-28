import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';

class AllListTile extends StatelessWidget {
  const AllListTile({super.key, required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: ListTile(
        tileColor: Theme.of(context).cardColor,
        leading: Icon(icon, color: AppColors.bgPrimary),
        title: Text(label, style: AppTextSytlyes.whiteTextStyle),
      ),
    );
  }
}
