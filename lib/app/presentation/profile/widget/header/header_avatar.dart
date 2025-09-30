import 'package:flutter/material.dart';
import 'package:neonappscase_gradproject/app/common/constants/app_icons.dart';
import 'package:neonappscase_gradproject/app/common/theme/app_colors.dart';
import 'package:neonappscase_gradproject/app/domain/model/account_model.dart';
import 'package:neonappscase_gradproject/app/presentation/profile/widget/header/profile_header.dart';

class HeaderAvatar extends StatelessWidget {
  const HeaderAvatar({
    super.key,
    required this.h,
    required this.w,
    required this.account,
    required this.avatarRadius,
  });

  final double h;
  final double w;
  final AccountModel? account;
  final double avatarRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h * 0.15,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [ProfileHeader(h: h, w: w, account: account)],
      ),
    );
  }
}
