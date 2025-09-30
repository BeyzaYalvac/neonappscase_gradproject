import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_textstyles.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.h,
    required this.w,
    required this.account,
  });

  final double h;
  final double w;
  final AccountModel? account;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * 0.1,
      width: w * 0.9,
      margin: EdgeInsets.fromLTRB(w * 0.05, h * 0.04, w * 0.05, 0),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? AppColors.bgSmoothDark
            : AppColors.bgPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: Text(
          account!.email,
          style: AppTextSytlyes.eMailTextStyle(context),
        ),
      ),
    );
  }
}
